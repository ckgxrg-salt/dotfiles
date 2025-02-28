import { Gtk } from "astal/gtk3";
import { Variable, execAsync } from "astal";

export default function MediaServices() {
	return <box className="MediaServices" halign={Gtk.Align.CENTER}>
		<Cava />
		<MPD />
	</box>;
}

function Cava() {
	const state = Variable(false);

	return <button
		className="CavaInactive"
		tooltipText="Our DJ is out for lunch"
		onClicked={self => {
			state.set(!state.get());
			if (state.get()) {
				self.set_class_name("CavaActive");
				self.set_tooltip_text("Our DJ C.A.V.A. is back!");
				execAsync(["systemctl", "--user", "start", "cava.service"]);
			} else {
				self.set_class_name("CavaInactive");
				self.set_tooltip_text("Our DJ is out for lunch");
				execAsync(["systemctl", "--user", "stop", "cava.service"]);
			}
		}}
	>
		<icon icon="audio-card" />
	</button>
}

function MPD() {
	const state = Variable(false);

	return <button
		className="MPDInactive"
		tooltipText="I'm here to disband Mpdchic"
		onClicked={self => {
			state.set(!state.get());
			if (state.get()) {
				self.set_class_name("MPDActive");
				self.set_tooltip_text("Climax! MPD's love letter to MPRIS!");
				execAsync(["systemctl", "--user", "start", "mpd.service"]);
				execAsync(["systemctl", "--user", "start", "mpd-mpris.service"]);
			} else {
				self.set_class_name("MPDInactive");
				self.set_tooltip_text("I'm here to disband Mpdchic");
				execAsync(["systemctl", "--user", "stop", "mpd.service"]);
				execAsync(["systemctl", "--user", "stop", "mpd-mpris.service"]);
			}
		}}
	>
		<icon icon="multimedia-player" />
	</button>
}
