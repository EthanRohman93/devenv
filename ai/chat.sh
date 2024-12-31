#!/bin/bash
cats() {
    file=$(fzf --query="$1" --select-1 --exit-0)
    if [[ -n "$file" ]]; then
        head -n 30 "$file" | cat --paging=never "$file"
    else
        echo "No matching file found."
    fi
}

vsys() {
    vim ./.system.md
}

vuser() {
    vim ./.user.md
}

vresp() {
    vim ./.response.md
}

ai() {
    local CURRENT_VENV="$VIRTUAL_ENV"
    # Check if arguments are given
    if [[ $# -gt 0 ]]; then
        # Append all arguments to ./.user.md
        echo "$*" >> ./.user.md
    else
        cats ./.user.md
    fi
    if [[ -n "$CURRENT_VENV" && "$(basename "$CURRENT_VENV")" != "openai_env" ]]; then
        pyenv deactivate
    fi
    if [[ -z "$VIRTUAL_ENV" || "$(basename "$VIRTUAL_ENV")" != "openai_env" ]]; then
        pyenv activate openai_env || { echo "Failed to activate openai_env"; return 1; }
    fi
    python ai.py
    local STATUS=$?
    if [[ -n "$CURRENT_VENV" && "$(basename "$CURRENT_VENV")" != "openai_env" ]]; then
        pyenv activate "$(basename "$CURRENT_VENV")" || { echo "Failed to restore original environment"; return 1; }
    elif [[ -z "$CURRENT_VENV" ]]; then
        pyenv deactivate
    fi
    if [[ $STATUS -eq 0 ]]; then
        echo "Process completed successfully."
        cats ./.response.md
    else
        echo "An error occurred during processing. Exit status: $STATUS" >&2
    fi
}

export OPENAI_API_KEY=""
