# Convert most .bashrc stuff to Powershell bc I have to use it sometimes.
# EXPERIMENTAL. Presumeably will have bugs.

# Located in ~/Documents/Powershell/profile.ps1
# Tested on Windows 10 and 11 .. powershell version is more important tho.

function convert {
    Write-Output "nah"
}
function fcd {
    Write-Output "nah"
}

function yts {
    start "https://www.youtube.com/results?search_query=$args"
}
nal yt yts

function ddg {
    start "https://lite.duckduckgo.com/lite/?q=$args"
}

function mwebinit {
    Write-Output "not tested; likely will error."
    cd ~\p\FrostyNick.github.io\
    live-server --ignore=.\index.md --browser=librewolf
}
function mweb {
    mwebinit
    cd $HOME - # doesn't do anything yet
}


function lt {
    ls *.txt; ls *.md
}
# nal ll 'ls -alF'
nal ll ls
nal la 'gci -Force'

# <c-d> is built-in to a different mode in newer powershell. There are multiple versions installed on Windows by default...
function e {exit}
function ^D {exit} # usually doesn't work if it ever did


# nal f fcd
nal v nvim
remove-item Alias:nv -Force
nal nv v
nal _ "nv ~\Documents\WindowsPowerShell\profile.ps1"

# nah
nal emacs "doom run"

# APIs are yes. https://wiki.quavergame.com/docs/api/users
# curl is an alias to a command in powershell (pain) (just on powershell in Windows)
# nal apiQuaver "Write-Output $(curl -s 'https://api.quavergame.com/v1/users/scores/recent?id=479240&mode=1&limit=10' 2>&1 | jq .scores[].\"max_combo\")"

nal live "live-server --browser=librewolf"
nal ytc "cd ~\p\commentsaver && live"
# below especially useful when the config inevitably breaks
nal lazy 'nv ~/.config/nvim/lua/frostynick/lazy.lua'
# no: nal uwuntu 'qemu-system-x86_64 -enable-kvm -cdrom ~/Downloads/UwUntu-22.10-desktop-amd64.iso -boot menu=on -drive file=~/Uwubuntu.img -m 4G -cpu host -vga virtio -display gtk,gl=on'
nal ndiff 'nv -d -R'
nal sendEB "Write-Output don't even try"

<# prerequisite with administrator privilages:

# NOTE: doesn't work with different versions of powershell.
Install-Module -Name BurntToast -RequiredVersion 0.8.5
# below should be prompted automatically, since BurntToast depends on below C# package manager
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
# Then select "Yes"
# Any other roadblocks? see github.com/Windos/BurntToast

#>

function notify-send { # Used in a .sh script, so it's a function
    # see above for dependencies; doesn't work when switching to older versions of powershell
    New-BurntToastNotification -Text "$args"
    # New-BurntToastNotification -Text 'release now', "it's so late"
}

nal invert "Write-Output l8r"

function fnalias { gcm | Out-String -Stream | Select-String "Function" }

## not done
# nal asdf "setxkbmap dvorak"
# nal aoeu "setxkbmap us"

nal obsn "ls ~\*.mkv | sort LastWriteTime | select -last 1"

# below is prep for wayland if that's supported in the future. works in theory. aliases need to be adjusted. todo!("paste into variable instead of file")
# alias antiw='wl-paste > /tmp/antichenalog02028 && sudo cat ~/.antichenalog | wl-copy'
# alias prow='wl-copy < /tmp/antichenalog02028 ; rm /tmp/antichenalog02028'
# wlr-randr (wayland xrandr)

nal anticn 'Write-Output no'
nal procn 'Write-Output no'

# remove-item Alias:nv -Force

function gits {
    git branch ; git status
}
function gitp {
    git push # ; procn # currently errors, with whitespace too
}
function gitpl {
    git pull # ; procn
}
nal gita 'git add'
nal gitd 'git diff'
nal gitm 'git commit -m'
nal gitcb 'git checkout -b'
function gitf {
    <# anticn && #>git fetch#;procn
}

# dt* aliases not tested

nal dtwarning 'Write-Output "All changes WILL be public."'
nal dt 'git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
nal dts 'dt status'
# Depending on your version of powershell, below commented out will error.
# function dtp {
#     dtwarning && anticn && dt push;procn
# }
# function dtpl {
#     anticn && dt pull;procn
# }
# nal dtd 'dt diff'
# function dtm {
#     dtwarning && dt commit -m
# }
# nal dtcb 'dt checkout -b'
# function dtq {
#     Write-Output WIP||dt add $1 || dt commit -m "Updated file"
# }
# function dtf {
#     anticn && dt fetch;procn
# }
# in future, below should also add and commit, but not commit other files
# (pseudocode: $(Write-Output $dts | grep "Changes to be committed") == "")

# skip warnings for these
nal dti3 'dt add ~/.config/i3/config'
nal dt_ 'dt add ~/.bashrc ~/.bash_aliases'

function dta {
    dtwarning
    # if [ $* == "." ]; then
    #     start "https://youtu.be/t4Z6_KJME_0"
    # else
        dt add "$args" # in theory works but idk. originally doesn't work with arguments
    # fi
}

## pomodoro related (src: https://gist.github.com/bashbunni/3880e4194e3f800c4c494de286ebc1d7 and https://youtu.be/GfQjJBtO-8Y )
## src vs this: remove dependencies with voice and progress bar (in ubuntu 20.04 no new dependencies needed) for minimal maintainance
# declare -A pomo_options
# pomo_options=(
#     ["work"]="2700" # 45 min
#     ["break"]="600" # 10 min
#     ["games"]="1800" # 30 min
#     ["test"]="5"
# )
#
# pomodoro () {
#   Write-Output "options: wo, br, br2, testbr."
#   if [ -n "$1" -a -n "{pomo_options["$1"]}" ]; then
#   val=$1;
#   timer=${pomo_options["$val"]};
#   Write-Output "$val session start. time: $timer sec. notification + interaction with shell will occur."
#   sleep $timer
#
#   # timer "${pomo_options["$val"]}m"
#   notify-send "'$val' session done."
#   fi
# }

# probably will error
nal wo "pomodoro 'work' &"
nal br "pomodoro 'break' &"
nal br2 "pomodoro 'games' &"
nal testbr "pomodoro 'test' &"

# alias.txt from tui app related
# function mo {
#     # moname=$*
#     moname=${*%.*}
#     # idea.txt becomes idea
#     nv ~/backup2022nov10/markor/$moname\.md
#     # nv "$(ls ~/backup2022nov10/markor/ | fzf)"
# }
function ia { nv $HOME\selfnotes\ideas.md }
function 2j { nv $HOME\selfnotes\2j.md }

# maybe future: create python/rust code to convert tui alias.txt format to .bash_aliases that
# are compatible with bash (such as url)... unless someone else already made one
# actually, a shortcut + fzf would be better than cluttering the terminal (maybe)
# until then, it's saved in android t-ui.
# syntax: tui <alias>

## Below makes fzf work with <c-r> and <c-t> with `scoop install fzf psfzf`
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function e. { explorer . }
