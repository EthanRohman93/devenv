#!/bin/bash
cats() {
    file=$1
    if [[ -n "$file" ]]; then
        head -n 30 "$file" | cat --paging=never "$file"
    else
        echo "No matching file found."
    fi
}

vsys() {
    vim /home/test_beast/devenv/ai/.system.md
}

vuser() {
    vim /home/test_beast/devenv/ai.user.md
}

vresp() {
    vim /home/test_beast/devenv/ai/.response.md
}

ai() {
    local CURRENT_VENV="$VIRTUAL_ENV"
    if [[ $# -gt 0 ]]; then
        echo "$*" >> /home/test_beast/devenv/ai/.user.md
    else
        cats /home/test_beast/devenv/ai/.user.md
    fi
    if [[ -n "$CURRENT_VENV" && "$(basename "$CURRENT_VENV")" != "openai_env" ]]; then
        pyenv deactivate
    fi
    if [[ -z "$VIRTUAL_ENV" || "$(basename "$VIRTUAL_ENV")" != "openai_env" ]]; then
        pyenv activate openai_env || { echo "Failed to activate openai_env"; return 1; }
    fi
    python /home/test_beast/devenv/ai/ai.py
    local STATUS=$?
    if [[ -n "$CURRENT_VENV" && "$(basename "$CURRENT_VENV")" != "openai_env" ]]; then
        pyenv activate "$(basename "$CURRENT_VENV")" || { echo "Failed to restore original environment"; return 1; }
    elif [[ -z "$CURRENT_VENV" ]]; then
        pyenv deactivate
    fi
    if [[ $STATUS -eq 0 ]]; then
        cats /home/test_beast/devenv/ai/.response.md
    else
        echo "An error occurred during processing. Exit status: $STATUS" >&2
    fi
}

export OPENAI_API_KEY=""
