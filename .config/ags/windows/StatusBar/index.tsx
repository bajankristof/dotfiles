import { Astal, type Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";

import { Sizing, Spacing } from "@/theme";
import Clock from "@/widgets/Clock";
import FocusedApp from "@/widgets/FocusedApp";
import NetworkStatus from "@/widgets/NetworkStatus";
import Power from "@/widgets/Power";
import Tray from "@/widgets/Tray";
import Workspaces from "@/widgets/Workspaces";

import Audio from "./widgets/Audio";
// TODO: Enable Bluetooth widget when implemented
//import Bluetooth from "./widgets/Bluetooth";
import NowPlaying from "./widgets/NowPlaying";

export default function StatusBar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name="statusbar"
      class="StatusBar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      heightRequest={Sizing.STATUS_BAR_HEIGHT}
      anchor={TOP | LEFT | RIGHT}
      margin={Spacing.MEDIUM}
      marginBottom={0}
      application={app}
    >
      <centerbox>
        <box $type="start">
          <box spacing={Spacing.MEDIUM}>
            <Workspaces
              icons={[
                "",
                "二",
                "三",
                "四",
                "五",
                "六",
                "七",
                "八",
                "九",
              ]}
            />
            <FocusedApp
              spacing={Spacing.MEDIUM}
              vexpand
              valign={Gtk.Align.CENTER}
            />
          </box>
        </box>
        <box $type="center">
          <NowPlaying />
        </box>
        <box $type="end" spacing={Spacing.MEDIUM}>
          <box spacing={Spacing.SMALL}>
            <Tray spacing={Spacing.SMALL} />
            {/*<Bluetooth />*/}
            <NetworkStatus widthRequest={Sizing.STATUS_BAR_HEIGHT} vexpand />
            <Audio />
            <Clock />
          </box>
          <Power />
        </box>
      </centerbox>
    </window>
  );
}
