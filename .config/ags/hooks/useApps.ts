import AstalApps from "gi://AstalApps";

let apps: AstalApps.Apps | undefined;

export default function useApps(): AstalApps.Apps {
  if (!apps) {
    apps = new AstalApps.Apps();
  }

  return apps;
}
