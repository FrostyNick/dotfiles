convert() {
    echo "This doesn't work right now. TODO"
    if [ $# -lt 3 ]; then
        echo "Usage: convert <format1> <format2> <file(s)>"
        return
    fi

    return # this doesn't work right now

    # validate input
    for file in $3; do
        nout=$(echo $file | awk -F '.' '{ print $file }' | sed "s/$/.$1/")
        nin=$(echo $file | awk -F '.' '{ print $file }' | sed "s/$/.$2/")
        echo "In: $nin Out: $nout"
        # ffmpeg -i $nin -acodec libvorbis $nout
        ffmpeg -i $nin $nout
    done
}
fcd() {
    cd "$(find -type d | fzf)" # taken from BugsWriter
}
yts() {
    xdg-open "https://www.youtube.com/results?search_query=$*"
}
alias yt="yts"
ddg() {
    xdg-open "https://lite.duckduckgo.com/lite/?q=$*" 
}
mwebinit() {
    cd ~/p/FrostyNick.github.io/ && live-server --ignore=./index.md --browser=librewolf
}
mweb() {
    mwebinit
    cd - # doesn't do anything yet
}
alias f=fcd
alias _="nv ~/.bash_aliases"
# alias b_="_"
alias py=python
alias nv=nvim
alias emacs="doom run"

alias rs="cd ~/p/ && echo hint hint :\)"
alias live="live-server --browser=librewolf"
alias ytc="cd ~/p/commentsaver && live"
# especially useful when the config inevitably breaks
alias lazy='nv ~/.config/nvim/lua/frostynick/lazy.lua'
alias uwuntu='qemu-system-x86_64 -enable-kvm -cdrom ~/Downloads/UwUntu-22.10-desktop-amd64.iso -boot menu=on -drive file=~/Uwubuntu.img -m 4G -cpu host -vga virtio -display gtk,gl=on'
alias ndiff='nvim -d -R'


nonoti() { # Used in a .sh script, so it's a function
    notify-send "DUNST_COMMAND_PAUSE"
}
noti() {
    notify-send "DUNST_COMMAND_RESUME"
}
export -f noti nonoti

alias nonotify="printf \"nonoti\n\" && nonoti"
alias notify="printf \"noti\n\" && noti"

alias fnalias="cat ~/.bash_aliases | grep '()'"
alias csci2050="echo sshpass -p \"xxxxxxxx\" ssh frostynick@woodducks; sshpass -p \"xxxxxxxx\" ssh frostynick@woodducks"
alias joplin-desktop="cd ~ && ./.joplin/Joplin.AppImage" # kms

# src: Avoid the password suggestion though. https://web.archive.org/web/20230630174028/https://superuser.com/questions/548234/how-can-i-easily-toggle-between-dvorak-and-qwerty-keyboard-layouts-from-a-linux/548235 
alias asdf="setxkbmap dvorak"
alias aoeu="setxkbmap us"
# alias asdf="sudo loadkeys dvorak" # doesn't work for some reason
# alias aoeu="sudo loadkeys us"

alias vidn="ls ~/Videos/simplescreenrecorder-* | xargs | rev | cut -d\  -f1 | rev" # It could be a lot more efficient
alias obsn="ls /home/nicholas/20*.mkv | xargs | rev | cut -d\  -f1 | rev"

# below is prep for wayland if that's supported in the future. works in theory. aliases need to be adjusted. todo!("paste into variable instead of file")
# alias antiw='wl-paste > /tmp/antichenalog02028 && sudo cat ~/.antichenalog | wl-copy'
# alias prow='wl-copy < /tmp/antichenalog02028 ; rm /tmp/antichenalog02028'
# wlr-randr (wayland xrandr)

alias anticn='aoeu && echo $(xclip -sel "clip" -o) | xclip -sel "secondary" && sudo -k cat ~/.antichenalog | xclip -sel "clip"'
alias procn='echo $(xclip -sel "secondary" -o) | xclip -sel "clip"'
    
alias gits='git branch;git status'
alias gitp='anticn && git push;procn'
alias gitpl='anticn && git pull;procn'
alias gita='git add'
alias gitd='git diff'
alias gitm='git commit -m'
alias gitcb='git checkout -b'
alias gitf='anticn && git fetch;procn'

alias dtwarning='echo "All changes WILL be public."'
alias dt='/nix/store/0cgj6agi5yzp4lyrzcnjwlidym2c84al-user-environment/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dts='dt status'
alias dtp='dtwarning && anticn && dt push;procn'
alias dtpl='anticn && dt pull;procn'
# aliasdota=function
alias dtd='dt diff'
alias dtm='dtwarning && dt commit -m'
alias dtcb='dt checkout -b'
alias dtq='echo WIP||dt add $1 || dt commit -m "Updated file"'
alias dtf='anticn && dt fetch;procn'
# in future, below should also add and commit, but not commit other files
# (pseudocode: $(echo $dts | grep "Changes to be committed") == "")
alias dti3='dta ~/.config/i3/config'
dta() {
    if [ $* == "." ]; then
        echo "https://youtu.be/t4Z6_KJME_0"
    else
        dt add "$*"
    fi
}

# tui related
mo() {
    # moname=$*
    moname=${*%.*}
    # idea.txt becomes idea
    nv ~/backup2022nov10/markor/$moname\.md
    # nv "$(ls ~/backup2022nov10/markor/ | fzf)"
}
alias ia='nv ~/backup2022nov10/markor/ideas.md'
alias 2j='nv ~/backup2022nov10/markor/j'

# maybe future: create python/rust code to convert tui alias.txt format to .bash_aliases that
# are compatible with bash (such as url)... unless someone else already made one
# actually, a shortcut + fzf would be better than cluttering the terminal (maybe)
# until then, it's saved in android t-ui.
# syntax: tui <alias>
