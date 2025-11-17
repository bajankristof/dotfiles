import GLib from "gi://GLib";
import { createPoll } from "ags/time";

export type ClockProps = Omit<JSX.IntrinsicElements["label"], "label">;

export default function Clock(props?: ClockProps) {
  const time = createPoll("", 1000, () => {
    const now = GLib.DateTime.new_now_local();
    return now.format("%H:%M") ?? "";
  });

  return <label class="Clock" {...props} label={time} />;
}
