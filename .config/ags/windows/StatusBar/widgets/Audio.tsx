import { Gtk } from "ags/gtk4";

import { bind } from "@/agsx";
import useDefaultSpeaker from "@/hooks/useDefaultSpeaker";
import MicrophoneControls from "@/widgets/MicrophoneControls";
import SpeakerControls from "@/widgets/SpeakerControls";

export type AudioProps = {
  halign?: Gtk.Align;
};

export default function Audio({ halign = Gtk.Align.CENTER }: AudioProps) {
  const volume = bind(useDefaultSpeaker(), "volume", 0);
  const icon = volume((v) => v === 0 ? "" : v < 0.5 ? "" : "");

  return (
    <menubutton class="Audio">
      <label label={icon} />
      <popover halign={halign} widthRequest={300}>
        <box orientation={Gtk.Orientation.VERTICAL}>
          <SpeakerControls />
          <MicrophoneControls />
        </box>
      </popover>
    </menubutton>
  );
}
