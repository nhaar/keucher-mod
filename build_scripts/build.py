import subprocess
import os
from pathlib import Path

from paths import UTMT, FLIPS, DEMO, SP, LTS

DIST_PATH = os.path.join(Path(__file__).resolve().parent, '..', 'dist')
SCRIPT_PATH = os.path.join(Path(__file__).resolve().parent, '..', 'src')

def get_script_path(name: str):
  return os.path.join(SCRIPT_PATH, name + '.csx')

VERSION = "5.2.0"

def build_version(data_win_path: str, script_name: str, version_name: str):
  data_win_output_path = os.path.join(DIST_PATH, f"data_{version_name}.win")
  script_path = os.path.join(SCRIPT_PATH, script_name + '.csx')
  subprocess.run([UTMT, "load", data_win_path, "-s", script_path, "-o", data_win_output_path])
  subprocess.run([FLIPS, "-c", "--bps", data_win_path, data_win_output_path, os.path.join(DIST_PATH, f"{version_name}_keucher-{VERSION}.bps")])

def build_demo_version(version: str):
  build_version(DEMO[version], 'Demo', f'demo_{version}')

def build_sp_version(version: str):
  build_version(SP[version], 'SurveyProgram', f'survey_program_{version}')

def build_lts(chapter: int):
  path = LTS[str(chapter)]
  script = 'ChapterSelect' if chapter == 0 else f'Chapter{chapter}'
  name = '_select' if chapter == 0 else str(chapter)
  build_version(path, script, f'chapter{name}_1.19')

build_demo_version('1.09')
build_demo_version('1.10')
build_demo_version('1.15')

build_sp_version('english')
build_sp_version('japanese')

build_lts(0)
build_lts(1)
build_lts(2)