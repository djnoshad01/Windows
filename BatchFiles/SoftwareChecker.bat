@echo off
SETLOCAL EnableExtensions
echo Verifying software is installed...
if exist "C:\Program Files (x86)\Java\jre1.8.0_172" (
	echo [92mJava 1.8-172 32-bit is installed![0m
	) else (
	echo [91mJava 1.8-172 32-bit is NOT installed![0m
	)
if exist "C:\Program Files\Java\jre1.8.0_172" (
	echo [92mJava 1.8-172 64-bit is installed![0m
	) else (
	echo [91mJava 1.8-172 64-bit is NOT installed![0m
	)
if exist "C:\Program Files\Siemens\JT2Go" (
	echo [92mJT2GO is installed![0m
	) else (
	echo [91mJT2GO is NOT installed![0m
	) 
if exist "C:\Program Files\Common Files\Microsoft Shared\ClickToRun\OfficeClickToRun.exe" (
	echo [91mOffice 365 is NOT removed![0m
	) else (
	echo [92mOffice 365 is removed![0m
	)
if exist "C:\Program Files (x86)\Common Files\microsoft shared\OFFICE15\Office Setup Controller\Setup.exe" ( 
	echo [92mOffice 2013 is installed![0m
	) else (
	echo [91mOffice 2013 is NOT installed![0m
	)
set EXE=SmcGui.exe
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% ( 
	echo [92mSymatec is running![0m
	) else (
	echo [91mSymatec is NOT running![0m
	)
pause