import EndpointList, {
  type EndpointListProps,
} from "@/components/WirePlumber/EndpointList";
import useSpeakers from "@/hooks/useSpeakers";

export type SpeakerListProps = Omit<EndpointListProps, "endpoints">;

export default function SpeakerList(props?: SpeakerListProps) {
  const speakers = useSpeakers();

  return <EndpointList class="SpeakerList" {...props} endpoints={speakers} />;
}
