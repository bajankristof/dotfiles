import type AstalNetwork from "gi://AstalNetwork";
import type { Accessor } from "ags";

import { bind } from "@/agsx";

import useNetwork from "./useNetwork";

export default function useWiredNetwork(): Accessor<AstalNetwork.Wired> {
  const network = useNetwork();
  return bind(network, "wired");
}
