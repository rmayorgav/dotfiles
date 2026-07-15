@echo off
set ROOT_DIR=%~dp0\..
echo %ROOT_DIR%
mkdir %USERPROFILE%\.config
mkdir %USERPROFILE%\.config\starship
copy %ROOT_DIR%\*.toml %USERPROFILE%\.config\starship
pause