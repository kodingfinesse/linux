#!/bin/sh

# Remove all pkg except those installed
sudo pacman -Sc 

# Remove all files
sudo pacman -Scc

# List unused
sudo pacman -Qtdq

# Remove unused
sudo pacman -Rns $(pacman -Qtdq)

# Remove user cache
rm -rf ~/.cache/*
