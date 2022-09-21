#!/bin/bash
## raphsh.sh v2.3 by Raphaël Casimir, 14.01.2019
## This script is a shell auto-configurator for ubuntu-like distros
## It also works with Linux Subsystem for Windows
## Do no use sudo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo apt-get update
sudo apt-get install zsh wget git gawk
zsh
cd ~
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
cd .oh-my-zsh/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

test=1
while [ $test -eq 1 ];
do
    read -p "Do you wish to use honukai theme? " yn
    case $yn in
        [Yy]* ) wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme; mv honukai.zsh-theme ~/.oh-my-zsh/themes/; sed -i "s/robbyrussell/honukai/" ~/.zshrc; test=0; break;;
        [Nn]* ) test=0;;
        * ) echo "Please answer y or n.";;
    esac
done
sudo chsh -s /bin/zsh $USER

cd ~
gawk -i inplace -f $DIR/zshrc.awk ~/.zshrc

echo "source ~/.zshrc" | zsh

function winDetect() {
    echo $(cat /proc/version | grep -i microsoft)
}

if [ "$(winDetect)" != "" ]
then
    printf "\n# Launch Zsh \nif [ -t 1 ]; then \nexec zsh \nfi" >> .bashrc
    chmod -R -w /home/$USER/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

echo "raphsh setup done, please log out and back in if changes are not applied"

sleep 3

zsh
