import type AstalTray from "gi://AstalTray";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

import useTray from "./useTray";

export default function useSpeakers(): Accessor<AstalTray.TrayItem[]> {
  return bind(useTray(), "items");
}
