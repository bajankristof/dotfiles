import AstalMpris from "gi://AstalMpris";
import { Gtk } from "ags/gtk4";

import { bind } from "@/agsx";
import useMediaPlayer from "@/hooks/useMediaPlayer";

export type MediaPlayerProps = Omit<
  JSX.IntrinsicElements["box"],
  "children" | "orientation"
>;

export default function MediaPlayer(props?: MediaPlayerProps) {
  const player = useMediaPlayer();

  const title = bind(player, "title", "");
  const artist = bind(player, "artist", "");
  const artwork = bind(player, "coverArt", "");
  const playbackStatus = bind(
    player,
    "playbackStatus",
    AstalMpris.PlaybackStatus.STOPPED,
  );

  const canControl = bind(player, "canControl", false);
  const canGoNext = bind(player, "canGoNext", false);
  const canGoPrevious = bind(player, "canGoPrevious", false);

  return (
    <box class="MediaPlayer" {...props}>
      <image pixelSize={92} file={artwork} />
      <box
        hexpand
        vexpand
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        orientation={Gtk.Orientation.VERTICAL}
      >
        <label label={title} />
        <label label={artist} />
        <box hexpand halign={Gtk.Align.CENTER}>
          <button
            visible={canGoPrevious}
            label=""
            onClicked={() => player.get()?.previous()}
          />
          <button
            visible={canControl}
            label={playbackStatus((s) =>
              s === AstalMpris.PlaybackStatus.PLAYING ? "" : "",
            )}
            onClicked={() => player.get()?.play_pause()}
          />
          <button
            visible={canGoNext}
            label=""
            onClicked={() => player.get()?.next()}
          />
        </box>
      </box>
    </box>
  );
}
