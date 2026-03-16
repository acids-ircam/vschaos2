import os
import subprocess

import setuptools

# imports __version__
exec(open('vschaos/version.py').read())

with open("README.md", "r") as readme:
    readme = readme.read()

with open("requirements.txt", "r") as requirements:
    requirements = requirements.read()

setuptools.setup(
    name="acids-vschaos2",
    version=__version__,  # type: ignore
    author="Axel Chemla--Romeu-Santos",
    author_email="chemla@ircam.fr",
    description="vschaos2: vintage neural audio synthesis",
    long_description=readme,
    long_description_content_type="text/markdown",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    install_requires=requirements.split("\n"),
    python_requires='>=3.8',
    include_package_data=True,
)
