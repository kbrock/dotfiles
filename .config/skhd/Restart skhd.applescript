-- Force-restart skhd when its keyboard hook stalls and typing lags or stops.
-- Built into ~/Applications/Restart skhd.app by setup.sh; click it from the Dock with the mouse.
do shell script "pkill -9 -x skhd; sleep 0.5; launchctl kickstart gui/$(id -u)/com.koekeishiya.skhd"
display notification "skhd restarted" with title "Restart skhd"
