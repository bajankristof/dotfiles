import EndpointList, {
  type EndpointListProps,
} from "@/components/WirePlumber/EndpointList";
import useMicrophones from "@/hooks/useMicrophones";

export type MicrophoneListProps = Omit<EndpointListProps, "endpoints">;

export default function MicrophoneList(props?: MicrophoneListProps) {
  const microphones = useMicrophones();

  return (
    <EndpointList class="MicrophoneList" {...props} endpoints={microphones} />
  );
}
