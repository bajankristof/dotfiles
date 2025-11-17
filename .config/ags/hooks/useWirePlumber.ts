import AstalWp from "gi://AstalWp";

let wp: AstalWp.Wp | undefined;

export default function useWirePlumber(): AstalWp.Wp {
  if (!wp) {
    wp = AstalWp.get_default();
  }

  return wp;
}
