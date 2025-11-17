import type AstalWp from "gi://AstalWp";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

import useAudio from "./useAudio";

export default function useDefaultMicrophone(): Accessor<AstalWp.Endpoint> {
  return bind(useAudio(), "defaultMicrophone");
}
