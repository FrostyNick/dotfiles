alias csci2050="echo sshpass -p \"kiaPSlEK62lzOil3\" ssh frostynick@74.208.52.43; sshpass -p \"kiaPSlEK62lzOil3\" ssh frostynick@74.208.52.43"
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
alias gits="git status"
alias py=python
mweb() {
    cd ~/p/website2022/ && live-server --ignore=/home/nicholas/p/website2022/index.md --browser=librewolf
}
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dots='dot status'

# future: create code to convert tui alias.txt format to .bash_aliases that are
# compatible with bash (such as url)... unless someone else already made one
# syntax: tui <alias>
