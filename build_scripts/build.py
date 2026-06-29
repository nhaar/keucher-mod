import subprocess
import shutil
import os
import re
from pathlib import Path

from paths import UTMT, FLIPS, CHAPTERS_102, DEMO_115, SWITCH_106, CH5_LATEST

DIST_PATH = os.path.join(Path(__file__).resolve().parent, '..', 'dist')
SCRIPT_PATH = os.path.join(Path(__file__).resolve().parent, '..', 'src')
BUILD_SCRIPTS = os.path.join(DIST_PATH, '..', 'build_scripts')
FINAL_PATH = os.path.join(DIST_PATH, 'final')
PATCH_FILES = os.path.join(FINAL_PATH, 'patch_files')

if Path(FINAL_PATH).is_dir():
  # make final files fresh
  shutil.rmtree(FINAL_PATH)

os.mkdir(FINAL_PATH)
os.mkdir(PATCH_FILES)

def get_script_path(name: str):
  return os.path.join(SCRIPT_PATH, name + '.csx')

version_file = os.path.join(SCRIPT_PATH, 'mod', 'common', 'version_label', 'mod_version.gml')

VERSION = ""

with open(version_file, 'r') as f:
  content = f.read()
  match = re.search(r'return "(.*)"', content)
  VERSION = match[1]

def build_version(data_win_path: str, script_name: str, version_name: str):
  data_win_output_path = os.path.join(DIST_PATH, f"data_{version_name}.win")
  script_path = os.path.join(SCRIPT_PATH, script_name + '.csx')
  subprocess.run([UTMT, "load", data_win_path, "-s", script_path, "-o", data_win_output_path])
  subprocess.run([FLIPS, "-c", "--bps", data_win_path, data_win_output_path, os.path.join(PATCH_FILES, f"{version_name}.bps")])

def build_full_release(chapter_paths, deltarune_version: str, chapters: int):
  for (version_name, script_name, ch) in [
    ('_select', 'ChapterSelect', '0'),
    *[(str(ch), 'Chapter' + str(ch), str(ch)) for ch in range(1, chapters + 1)]
    ]:
    build_version(chapter_paths[ch], script_name, f'{deltarune_version}-chapter{version_name}')

def build_demo(path, deltarune_version: str):
  build_version(path, 'Demo', f'{deltarune_version}-demo')

build_demo(DEMO_115, 'v1.15')
build_full_release(CHAPTERS_102, 'v1.02', 4)
build_full_release(SWITCH_106, 'v1.06-switch', 5)
build_full_release(CH5_LATEST, 'ch5_latest', 5)

# copying files over
shutil.copy2(FLIPS, os.path.join(PATCH_FILES, 'flips.exe'))
shutil.copy2(
  os.path.join(BUILD_SCRIPTS, 'patcher.bat'),
  os.path.join(FINAL_PATH, 'Keucher Mod Patcher (PC).bat')
)
shutil.copy2(
  os.path.join(BUILD_SCRIPTS, 'patcher_switch.bat'),
  os.path.join(FINAL_PATH, 'Keucher Mod Patcher (Switch).bat')
)
shutil.copy2(
  os.path.join(BUILD_SCRIPTS, 'readme.txt'),
  os.path.join(FINAL_PATH, '_READ ME.txt')
)