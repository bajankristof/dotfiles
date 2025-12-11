export PATH="$HOME/.local/bin:$PATH"

umask 0002

if uwsm check may-start; then
  uwsm start hyprland-uwsm.desktop
fi
