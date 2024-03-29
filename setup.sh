#!/bin/bash

set -e

echo "Linking up the dotfiles to your home directory ($HOME)"

folders_to_stow="tmux zsh lynx spacemacs vim"

cd ~/dotfiles
for d in $folders_to_stow
do
	echo "stowing "$d"..."
	stow "$d"
done
cd -


echo "DONE! These are not all the files (tmuxminator for example), so make sure
you check everything is working correctly."

