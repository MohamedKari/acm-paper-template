"""Copy figures used by document."""
import os
import shutil
from pathlib import Path

DEP_FILE = "handycontrols.dep"
TARGET_DIR = Path("exported_images")
EXTENSIONS = ["pdf", "pdf_tex", "png", "jpg"]

def copy_image_files():
    TARGET_DIR.mkdir(exist_ok=True, parents=True)
    with open(DEP_FILE, "r") as f:
        for line in f:
            if "*{file}" not in line:
                continue
            value = line.split("{")[2].split("}")
            source = value[0]
            _, e = os.path.splitext(source)
            e = e.lower()[1:]
            if e not in EXTENSIONS:
                continue
            print(source)
            shutil.copy(source, TARGET_DIR)


if __name__ == "__main__":
    copy_image_files()