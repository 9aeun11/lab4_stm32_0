@echo off
setlocal

if /I "%~1"=="mult_4bit" goto lab_ok
if /I "%~1"=="bcd_conv" goto lab_ok
echo Usage: run_fpga_sim.cmd mult_4bit^|bcd_conv
exit /b 2

:lab_ok
for %%I in ("%~dp0..") do set "ROOT=%%~fI"
if not exist "%ROOT%\vivado\verify_one.tcl" (
    echo Cannot find the FPGA simulation script.
    exit /b 3
)

for %%D in (S T U V W X Y Z) do (
    if not defined DRIVE if not exist %%D:\ set "DRIVE=%%D:"
)
if not defined DRIVE (
    echo No free drive letter is available for the Vivado simulation.
    exit /b 4
)

subst %DRIVE% "%ROOT%"
if errorlevel 1 exit /b 5
call "C:\AMDDesignTools\2026.1\Vivado\bin\vivado.bat" -mode batch -source "%DRIVE%/vivado/verify_one.tcl" -tclargs %~1
set "RESULT=%ERRORLEVEL%"
subst %DRIVE% /D
exit /b %RESULT%
