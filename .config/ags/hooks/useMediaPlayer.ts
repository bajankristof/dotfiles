import AstalMpris from "gi://AstalMpris";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

let mpris: AstalMpris.Mpris | undefined;

export default function useMediaPlayer(): Accessor<AstalMpris.Player> {
  if (!mpris) {
    mpris = AstalMpris.get_default();
  }

  const players = bind(mpris, "players");
  return players((p) => p[0]);
}
