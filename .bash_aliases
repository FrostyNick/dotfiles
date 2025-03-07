#!/bin/bash

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
ys() { # youtube summary .. AI tool that saves time :)
    # parses yt links (youtu.be or youtube.com) and removes extra link bloat.
    if [ $1 = "-h" ] || [ $1 = "--help"]; then
        echo Gets info from summarize.tech/youtu.be/id ... not perfect though.
        # TODO: Add -x that will execute xdg-open (or alt) in browser.
    fi
    id=$(echo $1 | sed 's/.*\=//' | sed 's/.*\///' | sed 's/\?.*//') 
    echo Downloading for $id
    echo "WARNING: Doesn't work on new videos. Doesn't show errors."
    url=https://www.summarize.tech/youtu.be/$id
    echo $url
    # WARNING: Doesn't work with -L
    librewolf -p $FFP $url
    # curl $url | pup 'section text{}'
    # TODO: If there's no results above, just open browser: xdg-open $url

    # curl https://www.summarize.tech/youtu.be/$id || xdg-open #| pup 'section text{}'
}

alias sm='s -b "librewolf -p $FFP" -p minecraftwiki'
alias sy='s -b "librewolf -p $FFP" -p youtube'
alias sz='s -b "librewolf -p $FFP"'

gp() { # goto project
    cd "$(ls -d --hyperlink=no ~/p/*$1* | head -n 1)"
}
gpf() { # goto project fzf
    cd "$(ls -d --hyperlink=no ~/p/*$1* | fzf)"
}
mp() { # mk project
    name=$1
    if [ -z $name ]; then
        name="test$(date +%N)"
    fi
    mkdir $HOME/p/$name
    cd $HOME/p/$name
    echo "Reminder that gp exists (goto project)"
}
alias p="cd ~/p"

b(){
    pf=$(ls ~/.librewolf/*.*/ -d --hyperlink=no | fzf)
    if [ $pf ]; then
        librewolf --profile $HOME/.librewolf/$pf &
    else
        echo Canceled launching.
    fi
}

f() {
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
# librewolfUnverified() {
#     script_url='https://gist.github.com/TheBrokenRail/c43bf0f07f4860adac2631a1bd9e4136/raw/jailbreak-firefox-system.sh'
#
#     # Download the script and save its contents
#     script_contents=$(curl -sSL "$script_url")
#
#     # Replace "firefox" with "librewolf" in the script contents
#     script_contents_modified=$(echo "$script_contents" | sed 's/firefox/librewolf/g')
#
#     # Display the modified script contents
#     echo "Script contents with 'firefox' replaced by 'librewolf':"
#     echo "$script_contents_modified"
#     echo "$script_contents"
#
#     read -p "Do you want to execute this modified script? (y/n): " response
#     if [ "$response" = "y" ]; then
#         echo "Executing the modified script..."
#         echo "$script_contents_modified" | sh
#     else
#         echo "Script execution canceled."
#     fi
#
# }


# more colors
export MANPAGER='nvim +Man!'
# commented below doesn't work at the very least in Ubuntu 20.04, probably old binaries / my setup
# export MANPAGER="less -R --use-color -Dd+r -Du+b"
# export MANROFFOPT="-P -c"
# export LESS='-R --use-color -Dd+r$Du+b$' # this won't work in Ubuntu 20.04 (there's no --use-color flag)

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --hyperlink'
    alias dmesg='dmesg --color'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias ip='ip -color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


alias lt='ls *.{txt,md}'
alias ll='ls -alF'
alias lh='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

tt(){
    if [ -z $1 ]; then
        echo "description: this is for translating sentences"
        echo "usage: sentence_with_%20_in_spaces original_lang target_lang # lang arguments are optional, bash script will autofill with some languages (no autodetecting language)."
        echo "example: cloudy%20day en pl"
        echo "example 2: yes uk"
        echo "where do I find languages?? Use \"ISO standard names or RFC3066\""
        echo "https://iso639-3.sil.org/code_tables/639/data/all"
        echo "https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes"
    else
        command -v jq >/dev/null || (echo jq is needed for this program to work.; return)
        local lang=$2
        local lang2=$3
        if [ -z $lang ]; then
            lang="en"
            lang2="pl"
            echo "Missing first+second language. Autogenerated."
        elif $(echo "$lang" | grep "|"); then
            echo "Don't use |"
        elif [ -z $lang2 ]; then
            if [ $lang1 = "en" ]; then
                lang2=$lang
                lang="pl"
            else
                lang2=$lang
                lang="en"
            fi
            echo "Missing second language. Autogenerated."
        fi
        echo "Using: $lang $lang2"
        echo -n "Response status: "
        curl -s "https://mymemory.translated.net/api/get?q=$1&langpair=$lang|$lang2" | jq ".responseStatus,.responseData" || echo No response
    fi
}
alias translate=tt

# dictloop(){
#   while :; do
#     read -p "dict: " input
#     dict $input
#   done
# }

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

alias ..=up
alias rm='rm -i'

alias _="nvim ~/.bash_aliases"

x() {
    xdg-open $1 &
}
xp() {
    librewolf -p $FFP $1 &
}

alias cx='chmod +x '
alias py=python
alias v=nvim
alias n=newsboat

alias yy="wl-copy --trim-newline"
alias yyd="wl-copy --clear"
alias pp=wl-paste

alias xyy='xclip -sel "clip"' # I haven't tested x{yy{,c},pp} yet
alias xyyd='echo -n | xclip -sel "clip"'
alias xpp='xclip -sel "clip" -o'

# below works according to network chuck. Though I like xsel tool better, I'd rather use xclip just bc dependencies use it more for some reason.
# alias xyy='xsel --input --clipboard'
# alias xpp='xsel --output --clipboard'

# From my eyes, inspiration for better nvim (though to be fair it has a
# different purpose). Emacs has a mature powerful ecosystem to learn from.
alias emacs="doom run"
alias govi="nvim --listen ~/.cache/nvim/godot.pipe ."

# self-notes: see rank
# APIs are yes. https://wiki.quavergame.com/docs/api/users

apiQuaver() {
    echo $(curl -s 'https://api.quavergame.com/v1/users/scores/recent?id=479240&mode=1&limit=10' 2>&1 | jq .scores[].\"max_combo\" | awk '{ total += $1 } END { print total/NR }') is your average max combo based on the last 10 maps.
}

alias live="live-server --browser=librewolf"
alias ytc="cd ~/p/commentsaver && live"
# below especially useful when the config inevitably breaks
alias lazy='nvim ~/.config/nvim/lua/frostynick/lazy.lua'
alias uwuntu='qemu-system-x86_64 -enable-kvm -cdrom ~/Downloads/UwUntu-22.10-desktop-amd64.iso -boot menu=on -drive file=~/Uwubuntu.img -m 4G -cpu host -vga virtio -display gtk,gl=on'
alias ndiff='nvim -d -R'
alias sendEB='kdeconnect-cli -d 5e34c84b_9369_423e_b131_7269b94b0aae --share ; echo xdg-open + kdeconnect works better'
alias discordU="echo Vesktop exists proably. Proceed? \(use diU\)"
alias diU='cd ~/Downloads/ && sudo apt install ./discord-0.0.*.deb && rm discord-0.0.*.deb || echo Failed to remove .deb file, maybe due to update error? Run diRm to continue removing ; cd && echo Also run discordV.'
alias diRm='rm ~/Downloads/discord-0.0.*.deb'

discordV() {
    cd
    if [ -f ~/Vencord.sh ]; then
        . ~/Vencord.sh
    else
        curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh > ~/Vencord.sh && chmod +x ~/Vencord.sh && cat ~/Vencord.sh ; echo "# ./Vencord.sh if installer looks alright"
    fi
    cd - ; echo oldcwd used btw
}

alias pulseaudioD="pipewireE"
alias pipewireD="pulseaudioE"
alias p-="pulseaudioE"

pipewireE() {
    systemctl --user --now disable pulseaudio.service pulseaudio.socket
    systemctl --user --now enable pipewire{,-pulse}.s{ocket,ervice}
}

pulseaudioE() {
    systemctl --user --now disable pipewire{,-pulse}.s{ocket,ervice}
    systemctl --user --now enable pulseaudio.service pulseaudio.socket
}

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
alias joplin-desktop="cd;./.joplin/Joplin.AppImage" # kms

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

alias anticnw='sudo -k cat ~/.antichenalog | wl-copy'
alias anticnx='aoeu && sudo -k cat ~/.antichenalog | xclip -sel clip' 
alias procnx='echo -n | xclip -sel clip'
alias anticn='[ $WAYLAND_DISPLAY ] && anticnw || anticnx'
alias procn='[ $WAYLAND_DISPLAY ] && (wl-copy --clear || echo Could not clear text in wl DONT PASTE) || echo -n | (xclip -sel clip || echo Could not clear text x11 DONT PASTE)'

alias gits='git remote -v;(git --no-pager branch||git branch);git status'
alias giths='gits;gh issue ls;gh pr ls' #gh repo view

alias gitp='git push'
alias gitpl='git pull'
alias gita='git add'
alias gitd='git diff'
alias gitm='git commit -m'
alias gitcb='git checkout -b'
alias gitf='git fetch'

alias gitmu='git fetch upstream && git checkout main && git merge upstream/main'
alias gitpp='anticn && git push;procn'
alias gitplp='anticn && git pull;procn'
alias gitfp='anticn && git fetch;procn'

alias dtwarning='echo "All changes WILL be public."'
alias dt='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dts='dt branch;dt status'
alias dtp='dtwarning && anticn && dt push;procn'
alias dtpl='dt pull'
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
    # if [ $* == "." ] | [ $* == "*"]; then
    if [ $* == "." ]; then
        xdg-open https://youtu.be/t4Z6_KJME_0
    else
        dt add "$*" # doesn't work with multiple arguments
    fi
}

# pomodoro related (src: https://gist.github.com/bashbunni/3880e4194e3f800c4c494de286ebc1d7 and https://youtu.be/GfQjJBtO-8Y )
# src vs this: remove dependencies with voice and progress bar (in ubuntu 20.04 no new dependencies needed) for minimal maintainance
declare -A pomo_options
pomo_options=(
    ["work"]="2700" # 45 min
    ["break"]="600" # 10 min
    ["games"]="1800" # 30 min
    ["test"]="5"
)

pomodoro () {
  echo "options: wo, br, br2, testbr."
  if [ -n "$1" -a -n "{pomo_options["$1"]}" ]; then
  val=$1;
  timer=${pomo_options["$val"]};
  echo "$val session start. time: $timer sec. notification + interaction with shell will occur."
  sleep $timer

  # timer "${pomo_options["$val"]}m"
  notify-send "'$val' session done."
  fi
}

alias wo="pomodoro 'work' &"
alias br="pomodoro 'break' &"
alias br2="pomodoro 'games' &"
alias testbr="pomodoro 'test' &"

# alias.txt from tui app related
mo() {
    # moname=$*
    moname=${*%.*}
    # idea.txt becomes idea
    nvim ~/backup2022nov10/markor/$moname\.md
    # nvim "$(ls ~/backup2022nov10/markor/ | fzf)"
}
alias ia='nvim ~/backup2022nov10/markor/ideas.md'
alias 2j="nvim ~/backup2022nov10/markor/j/$(date +%Y)/$(date +%m | sed 's/^0*//').md" # date doesn't work on FreeBSD or OSX based on some quick research. Instead see: man strftime

# maybe future: create python/rust code to convert tui alias.txt format to .bash_aliases that
# are compatible with bash (such as url)... unless someone else already made one
# actually, a shortcut + fzf would be better than cluttering the terminal (maybe)
# until then, it's saved in android t-ui.
# syntax: tui <alias>
# ~/.bashrc
