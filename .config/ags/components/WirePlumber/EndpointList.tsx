import type AstalWp from "gi://AstalWp";
import { type Accessor, For } from "ags";
import { Gtk } from "ags/gtk4";

import { type Accessible, bind, pack } from "@/agsx";

export type EndpointListProps = {
  endpoints: Accessible<AstalWp.Endpoint[]>;
} & Omit<JSX.IntrinsicElements["box"], "children" | "orientation">;

export default function EndpointList({
  endpoints,
  ...props
}: EndpointListProps) {
  return (
    <box {...props} orientation={Gtk.Orientation.VERTICAL}>
      <For each={pack(endpoints) as Accessor<AstalWp.Endpoint[]>}>
        {(endpoint) => {
          const device = bind(endpoint, "device");
          const name = bind(device, "description", "");
          const isDefault = bind(endpoint, "isDefault");
          const cssClasses = isDefault((f) =>
            f ? ["success", "selected"] : [],
          );

          return (
            <button
              label={name}
              cssClasses={cssClasses}
              onClicked={() => endpoint.set_is_default(true)}
            />
          );
        }}
      </For>
    </box>
  );
}
