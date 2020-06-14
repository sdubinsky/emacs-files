#!/bin/sh

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48
	  sudo dpkg -i ./keyring.deb
	  echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt update
    sudo apt -y install curl apcalc screen ghc vlc git i3 i3status i3lock cowsay fortune-mod postgresql postgresql-server-dev-all cowsay adb feh xserver-xorg-input-synaptics redshift exiftool net-tools python python2 syncthing dmenu ripgrep universal-ctags rename emacs26
    wget -o "hackttf.zip" https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
    unzip "hackttf.zip"
    sudo cp -r "ttf" /usr/local/share/fonts
    sudo rm /usr/bin/emacs
    sudo ln -s $(which emacs26) /usr/bin/emacs
    systemctl --user enable emacs
    systemctl --user start emacs
    systemctl --user enable redshift
    systemctl --user start redshift

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
touch emacs-files/locals.el
sudo systemctl --user restart emacs

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

echo Things to do after:
echo "1a: set natural scrolling(libinput): https://askubuntu.com/questions/1122513/how-to-add-natural-inverted-mouse-scrolling-in-i3-window-manager"
echo "1b: set natural scrolling(evdev): https://forums.fedoraforum.org/showthread.php?298702-How-to-set-up-system-wide-Natural-Scrolling-Reverse-Scrolling-for-a-mouse-in-Fedora"
echo "to check which driver, run xinput to find the id of the mouse, then xinput list-props mouse_id to see which driver is listed."
