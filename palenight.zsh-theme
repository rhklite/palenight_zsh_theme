# Custom theme created by Han Hu
# http://panmental.de/symbols/info.htm for symbols

NUM_COLOR=white

function conda_prompt_info {
    [[ -n ${CONDA_DEFAULT_ENV} ]] || return
    echo "[${CONDA_DEFAULT_ENV:t}]"
}

function git_prompt_info() {
    local ref
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_stash_status)$(git_commits_ahead)$(git_commits_behind)$(parse_git_dirty)$(git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
        
    fi
}

function git_symbol_reference(){
    echo "-----------------------------------------------"
    echo "git prompt theme created by Han Hu, June 30 2019"
    echo "git repo clean:$fg_bold[green]  ✓$reset_color"
    echo "git repo dirty:$fg_bold[red]  ✗$reset_color"
    echo "files modified:$fg_bold[yellow]  ⚡$reset_color"
    echo "files added:$fg_bold[yellow]     +$reset_color"
    echo "files deleted:$fg_bold[yellow]   -$reset_color"
    echo "files untracked:$fg_bold[yellow] ?$reset_color"
    echo "files renamed:$fg_bold[yellow]   ↻$reset_color"
    echo "commits ahead:$fg_bold[yellow]   ⇡$reset_color"
    echo "commits behind:$fg_bold[yellow]  ⇣$reset_color"
    echo "stashes:$fg_bold[yellow]        [#]$reset_color"
    echo "-----------------------------------------------"
    echo "$fg_bold[white](•_•) ( •_•)>⌐■-■ (⌐■_■)$reset_color"
}

function git_stash_status() {
    local INDEX STATUS
    INDEX=$(command git stash list &> /dev/null | wc -l)
    STATUS=""
    
    if [ $INDEX -gt 0 2> /dev/null ]; then
        STATUS=" ["$INDEX"]"
    fi
    echo $STATUS
}

function git_prompt_status() {
    local INDEX STATUS
    INDEX=$(command git status --porcelain -b 2> /dev/null)
    STATUS=""
    
    # look for modified files
    if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^ M" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^M" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^AM" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^MM" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^ T" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$NUM$STATUS"
    fi
    # look for newly added files
    if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^??" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$NUM$STATUS"
    fi
    if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^A" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^MM" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$NUM$STATUS"
    fi
    # look for renamed files
    if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^R" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$NUM$STATUS"
    fi
    # look for deleted files
    if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^ D" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^D" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^AD" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$NUM$STATUS"
        elif $(echo "$INDEX" | grep '^MD ' &> /dev/null); then
        NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^MD" | wc -l)%{$reset_color%}"
        STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$NUM$STATUS"
    fi
    
    # look for stashed files
    
    
    # TODO
    # look for unmerged files
    # if $(echo "$INDEX" | grep '^ UU ' &> /dev/null); then
    #   NUM="%{$fg_bold[$NUM_COLOR]%}$(command git status --porcelain 2>/dev/null| grep "^ UU" | wc -l)%{$reset_color%}"
    #   STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$NUM$STATUS"
    # fi
    # if $(echo "$INDEX" | grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    #   STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$NUM$STATUS"
    # fi
    # if $(echo "$INDEX" | grep '^## [^ ]\+ .*behind' &> /dev/null); then
    #   STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$NUM$STATUS"
    # fi
    # if $(echo "$INDEX" | grep '^## [^ ]\+ .*diverged' &> /dev/null); then
    #   STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$NUM$STATUS"
    # fi
    echo $STATUS
}

prompt_setup_richard(){
    ZSH_THEME_GIT_PROMPT_PREFIX="%{($reset_color%}%{$fg_bold[yellow]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color)%}"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[yellow]%} ?%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%} ⚡%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[yellow]%} +%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[yellow]%} -%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[yellow]%} ↻%{$reset_color%}"
    
    ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX="%{$fg_bold[yellow]%} ⇡"
    ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX="%{$fg_bold[yellow]%} ⇣"
    ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="%{$reset_color%}"
    # ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%} ⚡%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ✗%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✓%{$reset_color%}"
    
    
    # base_prompt='$(_virtualenv_prompt_info)%{$fg_bold[green]%}%n%{$reset_color%}%{$fg_bold[green]%}:%{$reset_color%}%{$fg_bold[blue]%}%0~%{$reset_color%}%{$fg_bold[red]%} %{$reset_color%}'
    # (4~|.../%2~|%~) makes the dir shows top 2 dir, if the dir path is more than 4 long.
    # base_prompt='%{$fg_bold[yellow]%}$(conda_prompt_info)%{$reset_color%}%{$fg_bold[yellow]%}$(virtualenv_prompt_info)%{$reset_color%}%{$fg_bold[green]%}%n%{$reset_color%}%{$fg_bold[green]%}:%{$reset_color%}%{$fg_bold[blue]%}%(4~|.../%2~|%~)%{$reset_color%}%{$fg_bold[red]%} %{$reset_color%}'
    base_prompt='%{$fg_bold[yellow]%}$(conda_prompt_info)%{$reset_color%}%{$fg_bold[green]%}%n%{$reset_color%}%{$fg_bold[green]%}:%{$reset_color%}%{$fg_bold[blue]%}%(4~|.../%2~|%~)%{$reset_color%}%{$fg_bold[red]%} %{$reset_color%}'
    post_prompt='%{$fg_bold[yellow]%} ➜%{$reset_color%} '
    
    base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
    post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")
    
    precmd_functions+=(prompt_precmd)
}

prompt_precmd(){
    local gitinfo=$(git_prompt_info)
    local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
    local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
    local prompt_length=${#exp_nocolor}
    
    local nl=""
    
    if [[ $prompt_length -gt 1 ]]; then
        nl=$'\n%{\r%}';
    fi
    PROMPT="$base_prompt$gitinfo$nl$post_prompt"
}

prompt_setup_richard


