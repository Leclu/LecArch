#!/bin/bash

# Checking if is running in Repo Folder
if [[ "$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')" =~ ^scripts$ ]]; then
    echo "You are running this in LecArch Folder."
    echo "Please use ./lecarch.sh instead"
    exit
fi

# Installing git

echo "Installing git."
pacman -Sy --noconfirm --needed git glibc

echo "Cloning the LecArch Project"
git clone https://github.com/Leclu/LecArch

echo "Executing LecArch Script"

cd $HOME/LecArch

exec ./lecarch.sh
