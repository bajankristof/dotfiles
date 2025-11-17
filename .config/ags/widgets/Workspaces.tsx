import { createComputed, For } from "ags";

import { bind } from "@/agsx";
import useFocusedWorkspace from "@/hooks/useFocusedWorkspace";
import useWorkspaces from "@/hooks/useWorkspaces";

export type WorkspacesProps = Omit<JSX.IntrinsicElements["box"], "children"> & {
  icons?: string[];
};

export default function Workspaces({
  icons = [],
  ...props
}: WorkspacesProps = {}) {
  const focusedWorkspace = useFocusedWorkspace();
  const unsortedWorkspaces = useWorkspaces();
  const workspaces = unsortedWorkspaces((w) => w.sort((a, b) => a.id - b.id));

  return (
    <box class="Workspaces" {...props}>
      <For each={workspaces}>
        {(workspace) => {
          const id = bind(workspace, "id", 1);
          const icon = id((i) => icons[i - 1]);
          const name = bind(workspace, "name", "");
          const label = createComputed([icon, name], (i, n) => i || n);
          const isFocused = createComputed(
            [focusedWorkspace, id],
            (w, i) => w?.id === i,
          );
          const cssClasses = isFocused((v) => (v ? ["warning"] : []));

          return (
            <button
              label={label}
              cssClasses={cssClasses}
              onClicked={() => !isFocused.get() && workspace.focus()}
            />
          );
        }}
      </For>
    </box>
  );
}
