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
mweb() {
    cd ~/p/website2022/ && live-server --ignore=/home/nicholas/p/website2022/index.md --browser=librewolf
}
alias f=fcd
alias _="nv ~/.bash_aliases"
# alias b_="_"
alias py=python
alias nv=nvim

alias live="live-server --browser=librewolf"
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

alias anticn='aoeu && echo $(xclip -sel "clip" -o) | xclip -sel "secondary" && sudo cat ~/.antichenalog | xclip -sel "clip"'
alias procn='echo $(xclip -sel "secondary" -o) | xclip -sel "clip"'
    
alias gits='git branch;git status'
alias gitp='anticn && git push;procn'
alias gitpl='anticn && git pull;procn'
alias gita='git add'
alias gitm='git commit -m'
alias gitcb='git checkout -b'
alias gitf='anticn && git fetch;procn'

alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dots='dot status'
alias dotp='anticn && dot push;procn'
alias dotpl='anticn && dot pull;procn'
# alias dota=function
alias dotm='dot commit -m'
alias gitcb='git checkout -b'
alias dotq='echo WIP||dot add $1 || dot commit -m "Updated file"'
alias dotf='anticn && dot fetch;procn'
# in future, below should also add and commit, but not commit other files
# (pseudocode: $(echo $dots | grep "Changes to be committed") == "")
alias doti3='dota ~/.config/i3/config'
dota() {
    if [ $* == "." ]; then
        echo "https://youtu.be/t4Z6_KJME_0"
    else
        dot add $*
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

# maybe future: create python/rust code to convert tui alias.txt format to .bash_aliases that
# are compatible with bash (such as url)... unless someone else already made one
# actually, a shortcut + fzf would be better than cluttering the terminal (maybe)
# until then, it's saved in android t-ui.
# syntax: tui <alias>
