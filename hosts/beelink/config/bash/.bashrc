if [ -z "$IN_NIX_SHELL" ]; then
    export PS1='\[\e[94m\]\W \[\e[0m\]$ '
else
    export PS1='\[\e[91m\]\W \[\e[0m\]$ '
fi

alias nixdev="nix develop"

export EDITOR=hx
