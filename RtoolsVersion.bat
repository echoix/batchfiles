@echo off

setlocal
rem if /i "%1"==path (path %2) && goto:eof

if not defined R_TOOLS for /f "tokens=2*" %%a in (
 'reg query hklm\software\R-core\Rtools /v InstallPath 2^>NUL ^| findstr InstallPath'
 ) do set R_TOOLS=%%~b
if not defined R_TOOLS for /f "tokens=2*" %%a in (
 'reg query hklm\software\wow6432Node\Rtools /v InstallPath 2^>NUL ^| findstr InstallPath'
  ) do set R_TOOLS=%%~b
if defined R_TOOLS goto:continue
if exist "C:\Rtools" set R_TOOLS=C:\Rtools
:continue

if not defined R_TOOLS goto:eof
if not exist "%R_TOOLS%\VERSION.txt" goto:msg
type %R_TOOLS%\VERSION.txt
goto:eof

:msg
echo RtoolsVersion.bat: No VERSION.txt found in %R_TOOLS%. Must be Rtools 2.12 or earlier. 

endlocal
