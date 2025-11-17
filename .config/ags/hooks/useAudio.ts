import type AstalWp from "gi://AstalWp";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

import useWirePlumber from "./useWirePlumber";

export default function useAudio(): Accessor<AstalWp.Audio> {
  return bind(useWirePlumber(), "audio");
}
