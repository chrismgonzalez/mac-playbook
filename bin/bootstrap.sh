#!/bin/sh
set e

xcode-select --install

export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH
sudo pip3 install --upgrade pip
pip3 install ansible

# when ready to run ansible playbook
# ansible-galaxy install -r requirements.yml
# ansible-playbook main.yml --ask-become-pass