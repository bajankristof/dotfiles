import { For } from "ags";
import type { Gtk } from "ags/gtk4";

import { bind } from "@/agsx";
import useTrayItems from "@/hooks/useTrayItems";

export type TrayProps = Omit<JSX.IntrinsicElements["box"], "children">;

export default function Tray(props?: TrayProps) {
  return (
    <box class="Tray" {...props}>
      <For each={useTrayItems()}>
        {(item) => {
          const init = (menubutton: Gtk.MenuButton) => {
            menubutton.menuModel = item.menuModel;
            menubutton.insert_action_group("dbusmenu", item.actionGroup);
            item.connect("notify::action-group", () => {
              menubutton.insert_action_group("dbusmenu", item.actionGroup);
            });
          };

          const gicon = bind(item, "gicon");

          return (
            <menubutton $={init}>
              <image $type="icon" gicon={gicon} />
            </menubutton>
          );
        }}
      </For>
    </box>
  );
}
