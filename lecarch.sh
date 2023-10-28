#!/bin/bash
#github-action genshdoc
#
# @file LecArch
# @brief Entrance script that launches children scripts for each phase of installation.

# Find the name of the folder the scripts are in
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
set +a
echo -ne "
-------------------------------------------------------------------------
 ___       _______   ________  ________  ________  ________  ___  ___     
|\  \     |\  ___ \ |\   ____\|\   __  \|\   __  \|\   ____\|\  \|\  \    
\ \  \    \ \   __/|\ \  \___|\ \  \|\  \ \  \|\  \ \  \___|\ \  \\\  \   
 \ \  \    \ \  \_|/_\ \  \    \ \   __  \ \   _  _\ \  \    \ \   __  \  
  \ \  \____\ \  \_|\ \ \  \____\ \  \ \  \ \  \\  \\ \  \____\ \  \ \  \ 
   \ \_______\ \_______\ \_______\ \__\ \__\ \__\\ _\\ \_______\ \__\ \__\
    \|_______|\|_______|\|_______|\|__|\|__|\|__|\|__|\|_______|\|__|\|__|
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Scripts are in directory named LecArch
"
    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
      source $CONFIGS_DIR/setup.conf
    ( bash $SCRIPT_DIR/scripts/0-preinstall.sh )|& tee 0-preinstall.log
    ( arch-chroot /mnt $HOME/LecArch/scripts/1-setup.sh )|& tee 1-setup.log
    if [[ ! $DESKTOP_ENV == server ]]; then
      ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/LecArch/scripts/2-user.sh )|& tee 2-user.log
    fi
    ( arch-chroot /mnt $HOME/LecArch/scripts/3-post-setup.sh )|& tee 3-post-setup.log
    cp -v *.log /mnt/home/$USERNAME

echo -ne "
-------------------------------------------------------------------------
 ___       _______   ________  ________  ________  ________  ___  ___     
|\  \     |\  ___ \ |\   ____\|\   __  \|\   __  \|\   ____\|\  \|\  \    
\ \  \    \ \   __/|\ \  \___|\ \  \|\  \ \  \|\  \ \  \___|\ \  \\\  \   
 \ \  \    \ \  \_|/_\ \  \    \ \   __  \ \   _  _\ \  \    \ \   __  \  
  \ \  \____\ \  \_|\ \ \  \____\ \  \ \  \ \  \\  \\ \  \____\ \  \ \  \ 
   \ \_______\ \_______\ \_______\ \__\ \__\ \__\\ _\\ \_______\ \__\ \__\
    \|_______|\|_______|\|_______|\|__|\|__|\|__|\|__|\|_______|\|__|\|__|
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
-------------------------------------------------------------------------
                Done - Please Eject Install Media and Reboot
"
