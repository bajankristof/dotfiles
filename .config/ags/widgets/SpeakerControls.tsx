import { Gtk } from "ags/gtk4";

import VolumeSlider from "@/components/WirePlumber/VolumeSlider";
import useDefaultSpeaker from "@/hooks/useDefaultSpeaker";
import SpeakerList from "./SpeakerList";

export type SpeakerControlsProps = Omit<
  JSX.IntrinsicElements["box"],
  "children" | "orientation"
>;

export default function SpeakerControls(props?: SpeakerControlsProps) {
  const defaultSpeaker = useDefaultSpeaker();

  return (
    <box
      class="SpeakerControls"
      {...props}
      orientation={Gtk.Orientation.VERTICAL}
    >
      <box hexpand>
        <label label="" />
        <VolumeSlider endpoint={defaultSpeaker} hexpand />
      </box>
      <SpeakerList />
    </box>
  );
}
