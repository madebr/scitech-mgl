@echo off
REM Setup environment variables for Visual C++ 5.0 32 bit edition

SET MSDevDir=%VC5_MSDevDir%
SET MSVCDir=%VC5_MSVCDir%

if .%CHECKED%==.1 goto checked_build
set LIB=%SCITECH_LIB%\LIB\RELEASE\WIN32\VC5;%MSVCDir%\LIB;.
echo Release build enabled.
goto setvars

:checked_build
set LIB=%SCITECH_LIB%\LIB\DEBUG\WIN32\VC5;%MSVCDir%\LIB;.
echo Checked debug build enabled.
goto setvars

:setvars
set TOOLROOTDIR=%MSVCDir%
set C_INCLUDE=%MSVCDir%\INCLUDE;
set INCLUDE=.;INCLUDE;%SCITECH%\INCLUDE;%PRIVATE%\INCLUDE;%C_INCLUDE%
set INIT=%MSVCDir%
SET MAKESTARTUP=%SCITECH%\MAKEDEFS\VC32.MK
call clrvars.bat
SET USE_WIN32=1
SET WIN32_GUI=1
SET VC_LIBBASE=vc5
PATH %SCITECH_BIN%;%MSVCDir%\BIN;%MSDevDir%\BIN;%DEFPATH%%VC32_CD_PATH%

REM: Enable Win32 SDK if desired (sdk on command line)
if NOT .%1%==.sdk goto done
call win32sdk.bat

:done
echo Visual C++ 5.0 32-bit Windows console compilation environment set up
