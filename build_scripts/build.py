import subprocess
import os
import re
from pathlib import Path

from paths import UTMT, FLIPS, CHAPTERS

DIST_PATH = os.path.join(Path(__file__).resolve().parent, '..', 'dist')
SCRIPT_PATH = os.path.join(Path(__file__).resolve().parent, '..', 'src')

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
  subprocess.run([FLIPS, "-c", "--bps", data_win_path, data_win_output_path, os.path.join(DIST_PATH, f"{version_name}_keucher-{VERSION}.bps")])

def build_chapter_version(chapter: int, version: str):
  build_version(CHAPTERS[str(chapter)], f'Chapter{chapter}', f'chapter{chapter}_v{version}')

def build_chapter_select(version: str):
  build_version(CHAPTERS['0'], f'ChapterSelect', f'chapter_select_v{version}')

build_chapter_select('14')
build_chapter_version(1, '1.36')
build_chapter_version(2, '1.42')
build_chapter_version(3, '89')
build_chapter_version(4, '88')