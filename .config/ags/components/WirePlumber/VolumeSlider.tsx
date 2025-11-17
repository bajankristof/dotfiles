import type AstalWp from "gi://AstalWp";

import { type Accessible, bind, unpack } from "@/agsx";

export type VolumeSliderProps = {
  endpoint: Accessible<AstalWp.Endpoint>;
} & Omit<
  JSX.IntrinsicElements["slider"],
  "min" | "max" | "value" | "onValueChanged"
>;

export default function VolumeSlider({
  endpoint,
  ...props
}: VolumeSliderProps) {
  const volume = bind(endpoint, "volume", 0);

  return (
    <slider
      {...props}
      min={0}
      max={1}
      value={volume}
      onValueChanged={({ value }: { value: number }) => {
        unpack(endpoint)?.set_volume(value);
      }}
    />
  );
}
