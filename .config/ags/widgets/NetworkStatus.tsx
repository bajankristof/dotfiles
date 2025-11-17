import AstalNetwork from "gi://AstalNetwork";
import { createComputed } from "ags";

import { bind } from "@/agsx";
import useWiredNetwork from "@/hooks/useWiredNetwork";
import useWirelessNetwork from "@/hooks/useWirelessNetwork";

export type NetworkStatusProps = Omit<JSX.IntrinsicElements["label"], "label">;

export default function NetworkStatus(props?: NetworkStatusProps) {
  const wired = useWiredNetwork();
  const wiredState = bind(wired, "state");
  const wireless = useWirelessNetwork();
  const wirelessState = bind(wireless, "state");

  const icon = createComputed([wiredState, wirelessState], (ws, wss) => {
    if (ws === AstalNetwork.DeviceState.ACTIVATED) {
      return "";
    } else if (wss === AstalNetwork.DeviceState.ACTIVATED) {
      return "";
    } else {
      return "";
    }
  });

  return <label class="NetworkStatus" {...props} label={icon} />;
}
