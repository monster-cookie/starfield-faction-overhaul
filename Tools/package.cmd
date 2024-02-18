@echo off

REM Get latest 7zip cli from https://www.7-zip.org/download.html (Want x64 7Zip Extras package) see https://documentation.help/7-Zip/syntax.htm for online docs

REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Tools"

REM Clear Dist DIR
del /q "C:\Users\degre\Downloads\VenworksFactionOverhaul.zip"
del /q "C:\Users\degre\Downloads\VenworksFactionOverhaul-CCMBH-Patch.zip"
del /q "C:\Users\degre\Downloads\VenworksFactionOverhaul-GrindTerraFactions-Patch.zip"
del /q "C:\Users\degre\Downloads\VenworksFactionOverhaul-AllFactions-Patch.zip"

REM Archive Dist Dir
"D:\Program Files\PexTools\7za.exe" a -r -tzip "C:\Users\degre\Downloads\VenworksFactionOverhaul.zip" "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Dist\*.*"
"D:\Program Files\PexTools\7za.exe" a -r -tzip "C:\Users\degre\Downloads\VenworksFactionOverhaul-CCMBH-Patch.zip" "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Dist-CCMBH-Patch\*.*"
"D:\Program Files\PexTools\7za.exe" a -r -tzip "C:\Users\degre\Downloads\VenworksFactionOverhaul-GrindTerraFactions-Patch.zip" "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Dist-GrindTerraFactions-Patch\*.*"
"D:\Program Files\PexTools\7za.exe" a -r -tzip "C:\Users\degre\Downloads\VenworksFactionOverhaul-AllFactions-Patch.zip" "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Dist-AllFactions-Patch\*.*"
