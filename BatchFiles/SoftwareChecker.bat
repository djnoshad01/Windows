@echo off
goto comment
###################################################################################
	SoftwareChecker.bat / 1.1
	
   Copyright 2019 kemotep

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   
	kemotep@gmail.com / https://github.com/kemotep/ 
###################################################################################
# This is an example batch file for checking if some software is installed on a given computer.
:comment
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