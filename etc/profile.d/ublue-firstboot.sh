if test "$(id -u)" -gt "0" && test -d "$HOME"; then
    if test ! -e "$HOME"/.config/autostart/ublue-firstboot.desktop; then
        mkdir -p "$HOME"/.config/autostart
        cp -f /usr/etc/skel.d/.config/autostart/ublue-firstboot.desktop "$HOME"/.config/autostart
    fi
fi