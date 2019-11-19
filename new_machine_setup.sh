#!/bin/sh

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt install curl apcalc screen ghc vlc git i3-wm i3status cowsay fortune-mod postgresql postgresql-server-dev-all cowsay adb feh xserver-xorg-input-synaptics redshift exiftool net-tools python python2 syncthing dmenu ripgrep universal-ctags
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt update && sudo apt -y install emacs26
    sudo rm /usr/bin/emacs
    sudo ln -s $(which emacs26) /usr/bin/emacs
    systemctl --user enable emacs
    systemctl --user start emacs
    systemctl --user enable redshift
    systemctl --user start redshift

    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb

elif [ "$(uname -s)" == "Darwin" ]; then
    xcode-select --install

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install ffmpeg android-platform-tools cowsay fortune gcc ledger make markdown mongodb pandoc postgresql python wget youtube-dl syncthing rename 

    brew install --HEAD universal-ctags
    brew link universal-ctags

    wget https://emacsformacosx.com/emacs-builds/Emacs-26.3-universal.dmg
    hdiutil mount Emacs-26.3-universal.dmg
    sudo cp -r /Volumes/Emacs/Emacs.app/ /Applications/Emacs.app
    hidutil unmount /Volumes/Emacs
    rm Emacs-26.2-universal.dmg
fi

git config --global user.name "Shalom Dubinsky"
git config --global user.email "smdubinsky@gmail.com"

cd ~
git clone https://github.com/sdubinsky/emacs-files.git
rm .bashrc .bash_profile .bash_aliases .profile
ln -s ~/emacs-files/.bashrc ~/.bashrc
ln -s ~/emacs-files/.bash_profile ~/.bash_profile
ln -s ~/emacs-files/.profile ~/.profile
ln -s ~/emacs-files/.bash_aliases ~/.bash_aliases

mkdir -p ~/.emacs.d
ln -s ~/emacs-files/init.el ~/.emacs.d/init.el
ln -s ~/emacs-files/emacs.service ~/.config/systemd/user/emacs.service
cp emacs-files/emacs.service ~/.config/systemd/user/emacs.service

wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install
cd ~
rm -rf chruby*

wget -O ruby-install-0.7.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz
tar -xzvf ruby-install-0.7.0.tar.gz 
cd ruby-install-0.7.0/
sudo make install
cd ~
rm -rf ruby-install*

ruby-install ruby
bash
chruby ruby
gem install bundler

cd ~
mkdir code

#Things to do after:
#1. Install the updated version of i3: https://i3wm.org/downloads/
#2. set natural scrolling: https://askubuntu.com/questions/1122513/how-to-add-natural-inverted-mouse-scrolling-in-i3-window-manager
