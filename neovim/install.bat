@echo off
powershell -Command "iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni """$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim""" -Force"
mkdir %LOCALAPPDATA%\nvim 2> NUL
copy init.vim %LOCALAPPDATA%\nvim\init.vim
nvim +PlugClean +PlugInstall +qa
nvim 
pause