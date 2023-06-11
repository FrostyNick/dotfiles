alias csci2050="echo sshpass -p \"xxxxxxxx\" ssh frostynick@woodducks; sshpass -p \"xxxxxxxx\" ssh frostynick@woodducks"
alias joplin-desktop="cd ~ && ./.joplin/Joplin.AppImage"
alias nv="nvim"
alias vidn="ls ~/Videos/simplescreenrecorder-* | xargs | rev | cut -d\  -f1 | rev"
fcd() {
    cd "$(find -type d | fzf)"
}
yts() {
    xdg-open "https://www.youtube.com/results?search_query=$*"
}
alias yt="yts"
ddg() {
    xdg-open "https://lite.duckduckgo.com/lite/?q=$*" 
}
alias anticn='echo $(xclip -sel "clip" -o) > /tmp/antichenalog02028 && sudo cat ~/.antichenalog | xclip -sel "clip"'
alias procn='cat /tmp/antichenalog02028 | xclip -sel "clip" ; rm /tmp/antichenalog02028'
# procn() {
    
alias gits="git status"
alias gitp='anticl && git push ; procn'
alias gita='git add'
alias gitm='git commit -m'
alias gitc=gitm
alias py=python
mweb() {
    cd ~/p/website2022/ && live-server --ignore=/home/nicholas/p/website2022/index.md --browser=librewolf
}
rweb() {
    cd ~/p/RhythmSwipe/ && live-server --browser=librewolf
}
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dots='dot status'
alias dotp='anticl && dot push ; procn'
alias dota='dot add'
alias dotm='dot commit -m'
# tui related
alias ia='nvim ~/backup2022nov10/markor/ideas.md'

# maybe future: create python/rust code to convert tui alias.txt format to .bash_aliases that
# are compatible with bash (such as url)... unless someone else already made one
# syntax: tui <alias>
