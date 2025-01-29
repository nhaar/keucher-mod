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
:: Path to the LTS data.win's
set ch1_path=
set ch2_path=
:: Path to the Survey Program data.win's (English and Japanese version)
set data_sp_en_path=
set data_sp_jp_path=
:: Path to the Undertale Mod Tool CLI
set umt_path=
:: Path to Floating IPS .exe
set flips_path=

:: Versions
set version=5.2.0

set batch_path=%~dp0
set dist_path=%batch_path%..\dist\
set src_path=%batch_path%..\src\
set script_demo_path=%src_path%Demo.csx
set script_ch1_path=%src_path%Chapter1.csx
set script_ch2_path=%src_path%Chapter2.csx
set script_sp_path=%src_path%SurveyProgram.csx

set data_1_15_out=%dist_path%data115.win
set data_1_10_out=%dist_path%data110.win
set data_1_09_out=%dist_path%data109.win
set data_ch1_out=%dist_path%dataCH1.win
set data_ch2_out=%dist_path%dataCH2.win
set data_sp_en_out=%dist_path%dataspen.win
set data_sp_jp_out=%dist_path%dataspjp.win

mkdir "%dist_path%"

"%umt_path%" load "%data_1_15_path%" -s "%script_demo_path%" -o "%data_1_15_out%"
"%umt_path%" load "%data_1_10_path%" -s "%script_demo_path%" -o "%data_1_10_out%"
"%umt_path%" load "%data_1_09_path%" -s "%script_demo_path%" -o "%data_1_09_out%"
"%umt_path%" load "%ch1_path%" -s "%script_ch1_path%" -o "%data_ch1_out%"
"%umt_path%" load "%ch2_path%" -s "%script_ch2_path%" -o "%data_ch2_out%"
"%umt_path%" load "%data_sp_en_path%" -s "%script_sp_path%" -o "%data_sp_en_out%"
"%umt_path%" load "%data_sp_jp_path%" -s "%script_sp_path%" -o "%data_sp_jp_out%"

"%flips_path%" -c --bps "%data_1_15_path%" "%data_1_15_out%" "%dist_path%demo_1.15_keucher-%version%.bps"
"%flips_path%" -c --bps "%data_1_10_path%" "%data_1_10_out%" "%dist_path%demo_1.10_keucher-%version%.bps"
"%flips_path%" -c --bps "%data_1_09_path%" "%data_1_09_out%" "%dist_path%demo_1.09_keucher-%version%.bps"
"%flips_path%" -c --bps "%data_sp_en_path%" "%data_sp_en_out%" "%dist_path%survey_program_english_keucher-%version%.bps"
"%flips_path%" -c --bps "%data_sp_jp_path%" "%data_sp_jp_out%" "%dist_path%survey_program_japanese_keucher-%version%.bps"
"%flips_path%" -c --bps "%ch1_path%" "%data_ch1_out%" "%dist_path%chapter1_1.19_keucher-%version%.bps"
"%flips_path%" -c --bps "%ch2_path%" "%data_ch2_out%" "%dist_path%chapter2_1.19_keucher-%version%.bps"