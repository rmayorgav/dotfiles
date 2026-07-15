@echo off
powershell -Command "iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force"
copy .vimrc %USERPROFILE%
vim +PlugInstall +qa