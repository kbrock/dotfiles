# choping block?

#profile

SSH_ENV=$HOME/.ssh/environment
SSHAGENT='/usr/bin/ssh-agent'
SSHAGENTARGS="-s"

function ssh_agent_kb {
    if [ -f "${SSH_ENV}" ]
    then
        . ${SSH_ENV} > /dev/null
#was aux
        if ps ax | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null
        then
           return
        fi
    fi
    echo "Initialising new SSH agent..."
    ${SSHAGENT} | sed 's/^echo/#echo/' > ${SSH_ENV}
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
    if [ -z "SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
      eval $(SSHAGENT $SSHAGENTARGS)
      trap "kill $SSH_AGENT_PID" 0
    fi
}
