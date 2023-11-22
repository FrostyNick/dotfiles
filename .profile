# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# for i3-sensible-terminal
# TERMINAL=wezterm; export TERMINAL 
# ^ this has stopped working. maybe the system has stopped recognizing this file for some reason??
# wezterm can be replaced by kitty btw
export TERMINAL=wezterm
# for dark theme on apps such as simplescrrec
export QT_STYLE_OVERRIDE=kvantum
# feh --randomize --bg-max ~/Pictures/wallpapers/*
feh --randomize --bg-fill ~/Pictures/wallpapers/*
setxkbmap -option caps:escape

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    echo "success"
    PATH="$HOME/.local/bin:$PATH"
else
    echo "fail"
fi
. "$HOME/.cargo/env"

if [ -e /home/nicholas/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nicholas/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
