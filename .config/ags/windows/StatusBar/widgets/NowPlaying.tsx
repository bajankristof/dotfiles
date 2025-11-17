import { type Accessible, bind } from "@/agsx";
import useMediaPlayer from "@/hooks/useMediaPlayer";
import { Spacing } from "@/theme";
import MediaPlayer from "@/widgets/MediaPlayer";

export type NowPlayingProps = {
  icon?: Accessible<string>;
};

export default function NowPlaying({ icon = "" }: NowPlayingProps) {
  const player = useMediaPlayer();
  const title = bind(player, "title", "");

  return (
    <menubutton class="NowPlaying" visible={title(Boolean)}>
      <box spacing={Spacing.MEDIUM}>
        <label label={icon} />
        <label label={title} />
      </box>
      <popover>
        <MediaPlayer />
      </popover>
    </menubutton>
  );
}
