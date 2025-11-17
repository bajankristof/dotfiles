import type AstalWp from "gi://AstalWp";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

import useAudio from "./useAudio";

export default function useDefaultSpeaker(): Accessor<AstalWp.Endpoint> {
  return bind(useAudio(), "defaultSpeaker");
}
