import AstalNetwork from "gi://AstalNetwork";

let network: AstalNetwork.Network | undefined;

export default function useNetwork(): AstalNetwork.Network {
  if (!network) {
    network = AstalNetwork.get_default();
  }

  return network;
}
