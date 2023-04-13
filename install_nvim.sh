#!/bin/bash
echo 'Hello' > file1
git clone https://github.com/neovim/neovim
(cd neovim && git checkout stable)
(cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo)
(cd neovim && sudo make install)
variable="alias vi = 'nvim'"
echo "$variable" >> $HOME/.bashrc
rm -r -f ./neovim
mv ./.config/nvim $HOME/.config/nvim
