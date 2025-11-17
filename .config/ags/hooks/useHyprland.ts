import AstalHyprland from "gi://AstalHyprland";

let hyprland: AstalHyprland.Hyprland | undefined;

export default function useHyprland(): AstalHyprland.Hyprland {
  if (!hyprland) {
    hyprland = AstalHyprland.get_default();
  }

  return hyprland;
}
