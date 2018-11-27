sudo apt install curl screen ghc emacs vlc git i3 cowsay fortune-mod postgresql postgresql-server-dev-all cowsay fortune-mod adb feh xserver-xorg-input-synaptics redshift exiftool

git config --global user.name "Shalom Dubinsky"
git config --global user.email "smdubinsky@gmail.com"

git clone https://github.com/sdubinsky/emacs-files.git
cp emacs-files/.bash* emacs-files/.profile ~
cp emacs-files/init.el ~/.emacs.d
cp emacs-files/emacs.service ~/.config/systemd/user/emacs.service

systemctl --user enable emacs
systemctl --user start emacs
systemctl --user enable redshift
systemctl --user start redshift

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

ls
git clone "https://github.com/xflux-gui/fluxgui.git"
cd fluxgui/
#python2 download-xflux.py 
#sudo python2 setup.py install
cd ~

wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install
cd ~

wget -O ruby-install-0.7.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz
tar -xzvf ruby-install-0.7.0.tar.gz 
cd ruby-install-0.7.0/
sudo make install
cd ~

ruby-install ruby
chruby ruby
gem install bundler

cd ~
mkdir code
