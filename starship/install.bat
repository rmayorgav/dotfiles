@echo off
mkdir %USERPROFILE%\.config 2> NUL
mkdir %USERPROFILE%\.config\starship 2> NUL
copy *.toml %USERPROFILE%\.config\starship
pause