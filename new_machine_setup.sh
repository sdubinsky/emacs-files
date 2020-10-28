#!/bin/sh
set -e
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48
	  sudo dpkg -i ./keyring.deb
	  echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt update
    sudo apt -y install curl apcalc screen ghc vlc git i3 i3status i3lock cowsay fortune-mod postgresql postgresql-server-dev-all cowsay adb feh xserver-xorg-input-synaptics redshift exiftool net-tools python python2 syncthing dmenu ripgrep universal-ctags rename emacs27 light sqlite3
    #This is for light, the program to change the backlight
    sudo usermod -a -G video $USER
    wget -O "hackttf.zip" https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
    unzip "hackttf.zip"
    sudo cp -r "ttf" /usr/local/share/fonts
    sudo rm /usr/bin/emacs
    sudo ln -s $(which emacs27) /usr/bin/emacs
    systemctl --user enable redshift
    systemctl --user start redshift
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

    . ~/.asdf/asdf.sh
    . ~/.asdf/completions/asdf.bash

elif [ "$(uname -s)" == "Darwin" ]; then
    xcode-select --install

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install ffmpeg android-platform-tools cowsay fortune gcc ledger make markdown mongodb pandoc postgresql python wget youtube-dl syncthing rename curl tmux mosh git cowsay fortune rename ripgrep sqlite3 apcalc coreutils asdf
    wget https://emacsformacosx.com/emacs-builds/Emacs-27.1-1-universal.dmg
    hdiutil mount Emacs-27.1.1-universal.dmg
    sudo cp -r /Volumes/Emacs/Emacs.app/ /Applications/Emacs.app
    hidutil unmount /Volumes/Emacs
    rm Emacs-27.1.1-universal.dmg

    . $(brew --prefix asdf)/asdf.sh
    . $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

fi

git config --global user.name "Shalom Dubinsky"
git config --global user.email "shalom.dubinsky@verbit.ai"

cd ~
git clone https://github.com/sdubinsky/emacs-files.git
rm -f .bashrc .bash_profile .bash_aliases .profile
ln -s ~/emacs-files/.bashrc ~/.bashrc
ln -s ~/emacs-files/.bash_profile ~/.bash_profile
ln -s ~/emacs-files/.profile ~/.profile
ln -s ~/emacs-files/.bash_aliases ~/.bash_aliases
touch emacs-files/locals.el
mkdir -p ~/.emacs.d
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    ln -s ~/emacs-files/init.el ~/.emacs.d/init.el
    ln -s ~/emacs-files/emacs.service ~/.config/systemd/user/emacs.service
    systemctl --user enable emacs
    systemctl --user start emacs
fi

asdf plugin add ruby
asdf install ruby 2.7.2

gem install bundler

cd ~
mkdir code

sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl


echo Things to do after:
echo "1a: set natural scrolling(libinput): https://askubuntu.com/questions/1122513/how-to-add-natural-inverted-mouse-scrolling-in-i3-window-manager"
echo "1b: set natural scrolling(evdev): https://forums.fedoraforum.org/showthread.php?298702-How-to-set-up-system-wide-Natural-Scrolling-Reverse-Scrolling-for-a-mouse-in-Fedora"
echo "to check which driver, run xinput to find the id of the mouse, then xinput list-props mouse_id to see which driver is listed."
