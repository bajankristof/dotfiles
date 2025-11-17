import { createComputed } from "ags";

import { bind } from "@/agsx";
import useFocusedApp from "@/hooks/useFocusedApp";
import useFocusedClient from "@/hooks/useFocusedClient";

export type FocusedAppProps = Omit<
  JSX.IntrinsicElements["box"],
  "children" | "visible"
>;

export default function FocusedApp(props?: FocusedAppProps) {
  const app = useFocusedApp();
  const client = useFocusedClient();
  const klass = bind(client, "class", "");
  const title = bind(client, "title", "");
  const name = createComputed([app, title], (a, t) => a?.name || t || "");

  return (
    <box class="FocusedApp" visible={name(Boolean)} {...props}>
      <image $type="icon" iconName={klass} />
      <label label={name} />
    </box>
  );
}
