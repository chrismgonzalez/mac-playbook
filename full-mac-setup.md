# Full Mac Setup Process

There are some things in life that just can't be automated... or aren't 100% worth the time :(

This document covers that, at least in terms of setting up a brand new Mac out of the box.

## Initial configuration of a brand new Mac

Before starting, I completed Apple's mandatory macOS setup wizard (creating a local user account, and optionally signing into my iCloud account). Once on the macOS desktop, I do the following (in order):

- Install Ansible (following the guide in [README.md](README.md))
- **Sign in in App Store** (since `mas` can't sign in automatically)
- Clone mac-dev-playbook to the Mac: `git clone git@github.com:chrismgonzalez/mac-playbook.git`
- If you elect to use your own `config.yml`, then replace the one in the repo with yours. 
- Run the playbook with `--skip-tags post`.
  - If there are errors, you may need to finish up other tasks like installing 'old-fashioned' apps first. Then, run the playbook again ;)
  - Start Synchronization tasks:
    - Open Photos and make sure iCloud sync options are correct
    - Open Music, make sure computer is authorized, and set Library sync options
  - Install old-fashioned apps:
    - (If required:)
      - Install [Elgato Stream Deck](https://www.elgato.com/en/downloads)
        - Open Livestream profile inside `~/Dropbox/Apps/Config/Stream Deck`
      - Install [Elgato Key Light Air (Control Center)](https://www.elgato.com/en/downloads)
      - Install [Autodesk Fusion 360](https://www.autodesk.com)
      - Install Microsoft Office Home & Student 2019 (https://account.microsoft.com/services/)
      - Install [Fritzing](https://fritzing.org/download/)
      - Install Meshmixer (but it looks like it's gone now!)
  - Open Calendar and enable personal  Google CalDAV account (you have to manually sign in).
  - Manually copy `~/Development` folder from another Mac (to save time), network storage, or clone select repos from Github.
  - Manual settings to automate someday:
    - System Preferences:
      - Accessibility > Display > Reduce transparency
      - Keyboard > Modifier Keys... > Caps Lock to Esc
    - Safari:
      - View > Show Status Bar
      - Preferences > Advanced > "Show full website address"
      - Preferences > Advanced > "Show Develop menu in menu bar"
    - Dock:
      - Add jgeerling, Downloads, Applications, and Video Projects folders
  - _After Dropbox Sync completes_: Run the playbook with `--tags post` to complete setup.
  - Symlink the synchronized `config.yml` into the playbook dir: `ln -s /Users/jgeerling/Dropbox/Apps/Config/mac-dev-playbook/config.yml /Users/jgeerling/Development/mac-dev-playbook/config.yml`
  - These things might be automatable, but I do them manually right now:
    - Configure Time Machine backup drive and [Time Machine Editor](https://tclementdev.com/timemachineeditor/) (if needed)
    - Install Wireguard from App Store and add configuration (if needed)

## To Wrap in Post-provision automation

The following tasks have to wait for the initial Dropbox sync to complete before they'll succeed. So ideally I'll stick this all in a post-provision script but somehow flag it not to run on first provision.

```
# ZSH Aliases.
ln -s /Users/jgeerling/Dropbox/Apps/Config/.aliases /Users/jgeerling/.aliases

# SSH setup.

# Ansible setup.
sudo mkdir -p /etc/ansible
sudo ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/ansible.cfg /etc/ansible/ansible.cfg
sudo ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/hosts /etc/ansible/hosts
sudo ln -s /Users/jgeerling/Dropbox/VMs/roles /etc/ansible/roles
mkdir -p /Users/jgeerling/.ansible
ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/galaxy_token /Users/jgeerling/.ansible/galaxy_token
ln -s /Users/jgeerling/Dropbox/Apps/Config/ansible/mm-vault-password.txt /Users/jgeerling/.ansible/mm-vault-password.txt
ln -s /Users/jgeerling/Dropbox/VMs/ /Users/jgeerling/.ansible/collections

# Font setup.
cp ~/Dropbox/Apps/Config/Fonts/* ~/Library/Fonts/

# Vim setup.
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle
cd ~/.vim/autoload
curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim > pathogen.vim
cd ~/.vim/bundle
git clone git://github.com/scrooloose/nerdtree.git
```

## When formatting for cleanup or reinstall

- Backup important documents to transfer to a new machine or reimaged machine at a later point
- Deauthorize Apple Music in iTunes/Music App
- Sync Chrome bookmarks. Alternatively, export bookmarks `.html` file to backup storage
- Make sure anything new merged into `~/Dropbox/Apps/Config`:
  - Fonts from ~/Library/Fonts
- Follow Apple's guide (TODO)
