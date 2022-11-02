import torch, GPUtil as gpu, math, torchcrepe, torchaudio, argparse, os, re, tqdm
from os.path import join

parser = argparse.ArgumentParser()
parser.add_argument('input', type=str, help="dataset folder")
parser.add_argument('-c', '--threshold', type=float, help="periodicity threshold", default=1e-2)
parser.add_argument('-l', '--hop_length', type=int, default=256)
parser.add_argument('--fmin', type=float, default=50.)
parser.add_argument('--fmax', type=float, default=1000.)
parser.add_argument('--batch_size', type=int, default=256)
args = parser.parse_args()


VALID_EXTS = ['.mp3', '.wav', '.aif', '.aiff', '.m4a', '.ogg', '.opus']
classes_octave = {i: i for i in range(9)}
classes_pitch = {'A': 0, 'A#': 1, 'B': 2, 'C': 3, 'C#': 4, 'D': 5, 'D#': 6, 'E': 7, 'F': 8, 'F#': 9, 'G': 10, 'G#': 11}

device = torch.device('cpu')
if torch.cuda.is_available() and int(os.environ.get("ENABLE_CUDA", 1)):
    visible_devices = os.environ.get("CUDA_VISIBLE_DEVICES", "")
    if visible_devices != "":
        device = torch.device('cuda:%s'%visible_devices.split(",")[0])
    elif gpu.getAvailable(maxMemory=0.05):
        available_devices = gpu.getAvailable(maxMemory=0.05)
        if len(available_devices) > 0:
            device = torch.device('cuda:%s'%available_devices[0])

def f_to_midi(frequency):
    note = round(12 * (math.log(frequency/220) / math.log(2)) + 57)
    octave = ((note+3) / 12) - 1
    noteIndex = ((note+3) % 12) 
    return noteIndex, octave

def write_class(class_file_path, class_dictionary):
    cout = 0
    with open(join(class_file_path), 'w+') as f:
        for label, label_id in class_dictionary.items():
            f.write('%i\t%s'%(label_id, label))
            if cout != len(class_dictionary):
                f.write('\n')
            cout += 1
                

def get_predictions(x, sr, hop_length, fmin, fmax, batch_size, device=device, avg_factor = 3, remove_quant=True, thresh=1.e-2):
    if x.ndim == 2:
        frequency = []
        periodicity = []
        for x_tmp in x:
            frequency_tmp, periodicity_tmp = torchcrepe.predict(x_tmp.unsqueeze(0), sr, hop_length, fmin, fmax, batch_size=batch_size, device=device, return_periodicity=True)
            frequency.append(frequency_tmp)
            periodicity.append(periodicity_tmp)
        frequency = torch.cat(frequency)
        periodicity = torch.cat(periodicity)
        periodicity_idxs = periodicity.argmax(dim=0)
        u = torch.stack([periodicity_idxs == i for i in range(frequency.shape[0])])
        frequency = frequency.masked_select(u).unsqueeze(0)
        periodicity = periodicity.masked_select(u).unsqueeze(0)
    else:
        frequency, periodicity = torchcrepe.predict(x.unsqueeze(0), sr, hop_length, fmin, fmax, batch_size=batch_size, device=device, return_periodicity=True)
    periodicity = torchcrepe.filter.median(periodicity, avg_factor)
    frequency = torchcrepe.threshold.At(thresh)(frequency, periodicity)
    if remove_quant:
        frequency = torchcrepe.filter.mean(frequency, avg_factor)
    return frequency[0], periodicity[0]
        

def parse_predictions(frequency, periodicity, hop_length, sr):
    count = 0
    pitch_str = ""
    octave_str = ""
    time = torch.arange(frequency.shape[0]) * hop_length / sr
    for slice_id in range(len(time)-2):
        if torch.isnan(frequency[slice_id]):
            pitch_str += "%f,%f\tNone"%(time[slice_id], time[slice_id+1])
            octave_str += "%f,%f\tNone"%(time[slice_id], time[slice_id+1])
        else: 
            pitch, octave = f_to_midi(frequency[slice_id])
            pitch_str += "%f,%f\t%i"%(time[slice_id], time[slice_id+1], pitch)
            octave_str += "%f,%f\t%i"%(time[slice_id], time[slice_id+1], octave)
        if count < len(time) - 3:
            pitch_str += "\n"
            octave_str += "\n"
        count += 1
    return pitch_str, octave_str


assert os.path.isdir(args.input), "%s does not seem to be a file"%args.input
args.input+="/"

input_dir = join(args.input, "data")
pitch_metadata_dir = join(args.input, "metadata", "pitch")
octave_metadata_dir = join(args.input, "metadata", "octave")
pitch_metadata_tracks_dir = join(args.input, "metadata", "pitch", "tracks")
octave_metadata_tracks_dir = join(args.input, "metadata", "octave", "tracks")
if not os.path.isdir(pitch_metadata_dir):
    os.makedirs(pitch_metadata_dir)
if not os.path.isdir(octave_metadata_dir):
    os.makedirs(octave_metadata_dir)
if not os.path.isdir(pitch_metadata_tracks_dir):
    os.makedirs(pitch_metadata_tracks_dir)
if not os.path.isdir(octave_metadata_tracks_dir):
    os.makedirs(octave_metadata_tracks_dir)

write_class(join(pitch_metadata_dir, 'classes.txt'), classes_pitch)
write_class(join(octave_metadata_dir, 'classes.txt'), classes_octave)
    
pitch_metadata_file = open(join(pitch_metadata_dir, "metadata.txt"), 'w+')
octave_metadata_file = open(join(octave_metadata_dir, "metadata.txt"), 'w+')
valid_files = []

for root, directory, files in os.walk(input_dir):
    valid_files_tmp = list(filter(lambda x: os.path.splitext(x)[1].lower() in VALID_EXTS, files))
    valid_files_tmp = list(filter(lambda x: x[0] != ".", valid_files_tmp))
    valid_files.extend([os.path.abspath(join(root, x)) for x in valid_files_tmp])

counter = 0
for current_file in tqdm.tqdm(valid_files, total=len(valid_files), desc="Extracting pitch from files..."):
    x, sr = torchaudio.load(join(root, current_file))
    frequency, periodicity = get_predictions(x, sr, args.hop_length, args.fmin, args.fmax, batch_size=args.batch_size, device=device, thresh=args.threshold)
    pitch_string, octave_string = parse_predictions(frequency, periodicity, args.hop_length, sr)
    current_file_path = re.sub(os.path.dirname(args.input)+'/', '', current_file)
    pitch_file_path = join(os.path.splitext(os.path.basename(current_file))[0]+".txt")
    octave_file_path = join(os.path.splitext(os.path.basename(current_file))[0]+".txt")
    pitch_metadata_file.write('%s\t%s'%(current_file_path, pitch_file_path))
    octave_metadata_file.write('%s\t%s'%(current_file_path, octave_file_path))
    with open(os.path.abspath(join(pitch_metadata_dir, 'tracks', pitch_file_path)), 'w+') as f:
        f.write(pitch_string)
    with open(os.path.abspath(join(octave_metadata_dir, 'tracks', octave_file_path)), 'w+') as f:
        f.write(octave_string) 
    if counter < len(valid_files):
        pitch_metadata_file.write('\n')
        octave_metadata_file.write('\n')
    counter += 1

pitch_metadata_file.close()
octave_metadata_file.close()

