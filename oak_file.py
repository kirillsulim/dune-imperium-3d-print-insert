from pathlib import Path
from shutil import rmtree

from oak_build import task, run


BUILD_DIR = Path("./build").absolute()

@task
def build():
    BUILD_DIR.mkdir(exist_ok=True)

    out_file = BUILD_DIR / "dune.stl"

    run(f"openscad -o '{out_file}' --export-format binstl main.scad")
    run(f"slic3r --split  '{out_file}'")


@task
def clean():
    rmtree(BUILD_DIR)
