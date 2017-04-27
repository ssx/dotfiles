#!/bin/bash

# Change some defaults
defaults write NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.ImageCapture disableHotPlug -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.loginwindow TALLogoutSavesState 0

# Set the library folder as hidden
chflags nohidden ~/Library/

# Don’t let Mac start on opening lid
sudo nvram AutoBoot=%00
sudo nvram BootAudio=%00
pmset -a hibernatemode 0
rm /var/vm/sleepimage

# Install Xcode tools
xcode-select --install

# Copy dotfiles over into user home directory
ln -s ~/Dropbox/.zshrc ~/.zshrc
ln -s ~/Dropbox/.gitconfig ~/.gitconfig
ln -s ~/Dropbox/.gitignore ~/.gitignore
ln -s ~/Dropbox/.ssh ~/.ssh

# Install homebrew and homebrew packages
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd ~/Dropbox/dotfiles
brew bundle
cd ~
gem install bundler
gem install jekyll

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"\
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"\
php composer-setup.php\
php -r "unlink('composer-setup.php');"\
sudo mv composer.phar /usr/local/bin/composer

# Install Laravel Valet
composer global require laravel/valet
valet install
valet domain valet
sudo brew services stop --all

# Install NPM modules
sudo npm install -g bower yarn cssunminifier gulp purify-css jasmine

# Install any rubygems
sudo gem install travis -v 1.8.8 --no-rdoc --no-ri

