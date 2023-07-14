# Evaluate snapshot of the command below, to reduce loading time.
#   eval "$(github-copilot-cli alias -- "$0")"
source ~/.dotfiles/.copilot-boot-snapshot.zsh

alias @start='sudo systemctl start'
alias @stop='sudo systemctl stop'
alias @restart='sudo systemctl restart'
alias @reload='sudo systemctl daemon-reload'
alias @rr='sudo systemctl daemon-reload && sudo systemctl restart'
alias @enable='sudo systemctl enable'
alias @disable='sudo systemctl disable'
alias @status='sudo systemctl status'
alias @logs='sudo journalctl -n 20 -fu'

# @edit
@edit() {
    sudo vim /etc/systemd/system/"$1"
}
_edit() {
    local -a services
    services=($(ls /etc/systemd/system | grep .service))
    _describe 'service' services
}
compdef _edit @edit

# @trace
@trace() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: @trace <service-name> <search-term>"
        return 1
    fi

    sudo journalctl -u $1 | grep $2
}
_trace() {
    local -a services
    services=($(ls /etc/systemd/system | grep .service))
    _describe 'service' services
}
compdef _trace @trace
