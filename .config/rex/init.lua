-- Rex config; linked to ~/.config/rex/init.lua by setup.sh
-- Reload with: rex config reload

-- cmd+k clears the screen; cmd+shift+k takes over cmd+k's default (Change Session)
rex.bind("cmd+k", "pane.send_key", { key = "ctrl+l" })
rex.bind("cmd+shift+k", "session.switch")

-- cmd+backspace clears the line (readline ctrl+u)
rex.bind("cmd+backspace", "pane.send_key", { key = "ctrl+u" })
