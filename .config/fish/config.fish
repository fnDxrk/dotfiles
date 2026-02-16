set -g fish_greeting

function add_newline --on-event fish_prompt
    if set -q add_newline_executed
        echo
    end
    set -g add_newline_executed
end

function clear
    command clear
    set -e add_newline_executed
end

function reset_starship_cmd_duration
    set -ge CMD_DURATION
    commandline -f execute
end

if status is-interactive
  starship init fish | source

  bind ctrl-h backward-kill-path-component
  bind alt-backspace backward-kill-path-component

  bind \r reset_starship_cmd_duration
end
