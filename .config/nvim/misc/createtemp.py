#! /bin/env python3 
from io import TextIOWrapper
from typing import Optional
import uuid 
from pathlib import Path


defaultpreset = Path("/home/johannes/.config/nvim/misc/apy_template.md")


def new_tmp_file() -> tuple[Path,TextIOWrapper]:
    unique_filename = str(uuid.uuid4()) + ".md"
    fpath = Path("/tmp/")
    fpath = fpath.joinpath(unique_filename)
    return fpath,open(fpath,"w")


def new_apy_file(preset: Path = defaultpreset) -> Path:
    npath, nfp = new_tmp_file()
    with open(preset,"r") as pr:
        nfp.write(pr.read())

    nfp.close()
    return npath

def main():
    file_path:Path = new_apy_file()
    print(str(file_path))

if __name__ == "__main__":
    main()

