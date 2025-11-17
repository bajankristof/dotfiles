import type AstalHyprland from "gi://AstalHyprland";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

import useHyprland from "./useHyprland";

export default function useFocusedClient(): Accessor<AstalHyprland.Client> {
  const hyprland = useHyprland();

  return bind(hyprland, "focusedClient");
}
