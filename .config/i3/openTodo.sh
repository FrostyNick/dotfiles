#!/usr/bin/env bash
$(which nvim || echo $HOME/.local/share/bob/nvim-bin/nvim) $HOME/dailytodo.md
# [ -d ~/bk/ ] && nvim ~/bk/markor/totodo.md
wait
