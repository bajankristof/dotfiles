export PATH="$HOME/.local/bin:$PATH"

if uwsm check may-start; then
  uwsm start hyprland-uwsm.desktop
fi
