@echo off

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Tools"

del /s /q "D:\MO2Staging\Starfield\mods\VenworksFactionOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher\*.*"
rmdir /s /q "D:\MO2Staging\Starfield\mods\VenworksFactionOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"
mkdir "D:\MO2Staging\Starfield\mods\VenworksFactionOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"

@echo "Deploying Main Archive to MO2 Mod DIR"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Dist\VenworksFactionOverhaul - Main.ba2" "D:\MO2Staging\Starfield\mods\VenworksFactionOverhaul-Experimental"

@echo "Deploying RTFP to MO2 Mod DIR"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Source\RTFP\VenworksCoreConfig.txt" "D:\MO2Staging\Starfield\mods\VenworksFactionOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-faction-overhaul\Source\RTFP\VenworksFactionOverhaulConfig.txt" "D:\MO2Staging\Starfield\mods\VenworksFactionOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"
