import type AstalHyprland from "gi://AstalHyprland";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

import useHyprland from "./useHyprland";

export default function useWorkspaces(): Accessor<AstalHyprland.Workspace[]> {
  const hyprland = useHyprland();

  return bind(hyprland, "workspaces");
}
