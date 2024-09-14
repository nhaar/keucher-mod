:: THIS IS A TEMPLATE FILE
:: YOU MUST SUPPLY ALL THE MISSING PATHS BELOW (ABSOLUTE PATH)
:: SCRIPT MUST BE RUN IN THE build_scripts FOLDER
:: RECOMMENDED TO MAKE A DIFFERENT FILE IN THIS FOLDER TO NOT BE IN git
:: Make sure to also update scripts with the proper versions

@echo off

:: Path to the vanilla DEMO data.win's (1.15, 1.10, 1.09)
set data_1_15_path=
set data_1_10_path=
set data_1_09_path=
:: Path to the Survey Program data.win's (English and Japanese version)
set data_sp_en_path=
set data_sp_jp_path=
:: Path to the Undertale Mod Tool CLI
set umt_path=
:: Path to Floating IPS .exe
set flips_path=

:: Versions
set demo_version=5.0.0
set sp_version=5.0.0

set batch_path=%~dp0
set dist_path=%batch_path%..\dist\
set src_path=%batch_path%..\src\
set script_1_15_path=%src_path%Demo-1.15.csx
set script_1_10_path=%src_path%Demo-1.10.csx
set script_sp_path=%src_path%SurveyProgram.csx

set data_1_15_out=%dist_path%data115.win
set data_1_10_out=%dist_path%data110.win
set data_1_09_out=%dist_path%data109.win
set data_sp_en_out=%dist_path%dataspen.win
set data_sp_jp_out=%dist_path%dataspjp.win

mkdir "%dist_path%"

"%umt_path%" load "%data_1_15_path%" -s "%script_1_15_path%" -o "%data_1_15_out%"
"%umt_path%" load "%data_1_10_path%" -s "%script_1_10_path%" -o "%data_1_10_out%"
"%umt_path%" load "%data_1_09_path%" -s "%script_1_10_path%" -o "%data_1_09_out%"
"%umt_path%" load "%data_sp_en_path%" -s "%script_sp_path%" -o "%data_sp_en_out%"
"%umt_path%" load "%data_sp_jp_path%" -s "%script_sp_path%" -o "%data_sp_jp_out%"

"%flips_path%" -c --bps "%data_1_15_path%" "%data_1_15_out%" "%dist_path%demo_1.15_keucher-%demo_version%.bps"
"%flips_path%" -c --bps "%data_1_10_path%" "%data_1_10_out%" "%dist_path%demo_1.10_keucher-%demo_version%.bps"
"%flips_path%" -c --bps "%data_1_09_path%" "%data_1_09_out%" "%dist_path%demo_1.09_keucher-%demo_version%.bps"
"%flips_path%" -c --bps "%data_sp_en_path%" "%data_sp_en_out%" "%dist_path%survey_program_english_keucher-%sp_version%.bps"
"%flips_path%" -c --bps "%data_sp_jp_path%" "%data_sp_jp_out%" "%dist_path%survey_program_japanese_keucher-%sp_version%.bps"