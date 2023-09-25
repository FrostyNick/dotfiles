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

# enable color support of ls and also add handy aliases (src: ubuntu bashrc)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --hyperlink'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
alias sendEB='kdeconnect-cli -d 5e34c84b_9369_423e_b131_7269b94b0aae --share'
alias sendEbook=sendEB
alias discordU='cd ~/Downloads/ && sudo apt install ./discord-0.0.*.deb && rm discord-0.0.*.deb ; cd'


nonoti() { # Used in a .sh script, so it's a function
    notify-send "DUNST_COMMAND_PAUSE"
}
noti() {
    notify-send "DUNST_COMMAND_RESUME"
}
export -f noti nonoti

alias nonotify="printf \"nonoti\n\" && nonoti"
alias notify="printf \"noti\n\" && noti"

alias invert="xcalib -invert -alter" # works on Ububtu 18.04+
# never tried: alias tomarkdown="pandoc --from html --to markdown_strict --wrap=none --no-highlight"
alias pandocmd="echo Argument: file/URL. Result is in output.md if success && pandoc -o output.md -f html -t markdown_strict "

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

# skip warnings for these
alias dti3='dt add ~/.config/i3/config'
alias dt_='dt add ~/.bashrc ~/.bash_aliases'

dta() {
    dtwarning
    if [ $* == "." ]; then
        echo "https://youtu.be/t4Z6_KJME_0"
    else
        dt add "$*"
    fi
}

# pomodoro related (src: https://gist.github.com/bashbunni/3880e4194e3f800c4c494de286ebc1d7 and https://youtu.be/GfQjJBtO-8Y )
# src vs this: remove dependencies with voice and progress bar (in ubuntu 20.04 no new dependencies needed) for minimal maintainance
declare -A pomo_options
pomo_options=(
    ["work"]="2700" # 45 min
    ["break"]="600" # 10 min
    ["games"]="1800" # 30 min
)

pomodoro () {
  echo "options: wo, br, br2."
  if [ -n "$1" -a -n "{pomo_options["$1"]}" ]; then
  val=$1;
  timer=${pomo_options["$val"]};
  echo "$val session start. time: $timer sec"
  sleep $timer

  # timer "${pomo_options["$val"]}m"
  notify-send "'$val' session done."
  fi
}

alias wo="pomodoro 'work' &"
alias br="pomodoro 'break' &"
alias br2="pomodoro 'games' &"

# tui related
mo() {
    # moname=$*
    moname=${*%.*}
    # idea.txt becomes idea
    nv ~/backup2022nov10/markor/$moname\.md
    # nv "$(ls ~/backup2022nov10/markor/ | fzf)"
}
alias ia='nv ~/backup2022nov10/markor/ideas.md'
alias 2j="nv ~/backup2022nov10/markor/j/$(date +%Y)/$(date +%m | sed 's/^0*//').md" # date doesn't work on FreeBSD or OSX based on some quick research. Instead see: man strftime

# maybe future: create python/rust code to convert tui alias.txt format to .bash_aliases that
# are compatible with bash (such as url)... unless someone else already made one
# actually, a shortcut + fzf would be better than cluttering the terminal (maybe)
# until then, it's saved in android t-ui.
# syntax: tui <alias>
