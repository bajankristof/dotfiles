import { Gtk } from "ags/gtk4";

import VolumeSlider from "@/components/WirePlumber/VolumeSlider";
import useDefaultMicrophone from "@/hooks/useDefaultMicrophone";
import MicrophoneList from "./MicrophoneList";

export type MicrophoneControlsProps = Omit<
  JSX.IntrinsicElements["box"],
  "children" | "orientation"
>;

export default function MicrophoneControls(props?: MicrophoneControlsProps) {
  const defaultMicrophone = useDefaultMicrophone();

  return (
    <box
      class="MicrophoneControls"
      {...props}
      orientation={Gtk.Orientation.VERTICAL}
    >
      <box hexpand>
        <label label="" />
        <VolumeSlider endpoint={defaultMicrophone} hexpand />
      </box>
      <MicrophoneList />
    </box>
  );
}
