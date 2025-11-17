// TODO: Actually implement this thing...
import useBluetoothAdapter from "@/hooks/useBluetoothAdapter";
import BluetoothControls from "@/widgets/BluetoothControls";

export default function Bluetooth() {
  const adapter = useBluetoothAdapter();

  return (
    <menubutton class="Bluetooth" visible={adapter(Boolean)}>
      <label label="" />
      <popover>
        <BluetoothControls />
      </popover>
    </menubutton>
  );
}
