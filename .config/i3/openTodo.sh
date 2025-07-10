#!/usr/bin/env bash
$(which nvim || echo $HOME/.local/share/bob/nvim-bin/nvim) $HOME/dailytodo.md
# [ -d ~/backup2022nov10/ ] && nvim ~/backup2022nov10/markor/totodo.md || nvim ~/backup2022nov/markor/totodo.md
wait
