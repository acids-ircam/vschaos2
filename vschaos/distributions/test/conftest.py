import os, pytest


@pytest.fixture
def test_path():
    figure_path = f"{os.path.dirname(os.path.abspath(__file__))}/figures"
    if not os.path.isdir(figure_path):
        os.makedirs(figure_path)
    return figure_path