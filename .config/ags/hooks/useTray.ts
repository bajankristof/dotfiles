import AstalTray from "gi://AstalTray";

let tray: AstalTray | undefined;

export default function useTray() {
  if (!tray) {
    tray = AstalTray.get_default();
  }

  return tray;
}
