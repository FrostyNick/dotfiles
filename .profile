# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# FUTURE: Move all this to i3 and sway if possible to make it less specific to how arch/ubuntu/etc work. (Note for anyone looking at src code: At the time of commit, this is only used in Ubuntu and X11.)

# for i3-sensible-terminal
# TERMINAL=wezterm; export TERMINAL 
# ^ this has stopped working. maybe the system has stopped recognizing this file for some reason??
# alternatives to kitty: wezterm, alacritty, st, (on ubuntu 20.04 using nix package manager) foot
export TERMINAL=alacritty
export EDITOR=vi
export VISUAL=vi
# for dark theme on apps such as simplescrrec
export QT_STYLE_OVERRIDE=kvantum
# Add below if using sway
export XDG_CURRENT_DESKTOP="sway"
# feh --randomize --bg-max ~/backup2*/wallpapers/active/*
feh --randomize --bg-fill ~/backup2*/wallpapers/active/*

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
