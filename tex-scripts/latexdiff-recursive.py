#!/usr/bin/env python
"""
recursively runs latexdiff
Assumes old files are all in one directory, and new files are all in another directory.
"""
from argparse import ArgumentParser
from pathlib import Path
import subprocess


def main():
    p = ArgumentParser()
    p.add_argument('old', help='old path')
    p.add_argument('new', help='new path')
    p.add_argument('out', help='output path')
    p = p.parse_args()

    old = Path(p.old).expanduser().resolve(True)
    new = Path(p.new).expanduser().resolve(True)
    out = Path(p.out).expanduser().resolve(True)

    assert old.is_dir() and new.is_dir() and out.is_dir()
    assert not out.samefile(new) and not out.samefile(old) and not old.samefile(new)

    flist = list(old.glob('**/*.tex'))
    if len(flist) == 0:
        raise FileNotFoundError(f'no *.tex files found in {old}')

    for fn in flist:
        newfn = (new/fn.relative_to(old))
        if not newfn.is_file():
            print('skipping non-existent', newfn)
            continue

        print('comparing', fn)

        ret = subprocess.check_output(['latexdiff', str(fn), str(newfn)], universal_newlines=True)

        (out/fn.name).write_text(ret)


if __name__ == '__main__':
    main()