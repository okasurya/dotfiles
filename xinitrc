# to support java app on dwm
export _JAVA_AWT_WM_NONREPARENTING=1

# tableplus tweak
systemctl --user import-environment DISPLAY XAUTHORITY
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# slstatus &
goblocks &
~/.fehbg &
bluetoothctl power on
~/.start/externalMon &
dunst &

exec ~/.start/dwmexec
# exec dwm
