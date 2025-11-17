import { exec } from "ags/process";

export type PowerProps = Omit<JSX.IntrinsicElements["button"], "onClicked">;

export default function Power(props?: PowerProps) {
  return (
    <button
      class="Power"
      label=""
      {...props}
      onClicked={() => exec("systemctl poweroff")}
    />
  );
}
