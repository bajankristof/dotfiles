import type AstalApps from "gi://AstalApps";
import type { Accessor } from "ags";

import useApps from "./useApps";
import useFocusedClient from "./useFocusedClient";

export default function useFocusedApp(): Accessor<
  AstalApps.Application | undefined
> {
  const apps = useApps();
  const client = useFocusedClient();

  return client((c) => {
    if (!c) {
      return undefined;
    }

    return apps.list.find((a) => {
      const wmClass = a.wmClass?.toLowerCase();
      return (
        wmClass &&
        (wmClass === c?.class?.toLowerCase() ||
          wmClass === c?.initialClass?.toLowerCase())
      );
    });
  });
}
