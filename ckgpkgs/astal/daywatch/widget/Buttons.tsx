import { App, Gtk, Astal } from "astal/gtk3";
import { Variable } from "astal";

export default function Buttons() {
	return <box
		vertical
		className="Buttons"
	>
		<Apps />
		<Power />
		<Coffee />
	</box>;
}

function Apps() {
	return <button
		className="Apps"
		onClicked="uwsm app -- rofi -show drun"
	>
		<icon icon="start-here" />
	</button>;
}

function Power() {
	return <button
		className="Power"
		onClicked="uwsm app -- wlogout"
	>
		<icon icon="system-shutdown" />
	</button>;
}

// Inhibits screenlocker
function Coffee() {
	const state = Variable(false);
	const inhibitId = Variable(0);

	return <button
		className="CoffeeZzz"
		onClicked={self => {
			state.set(!state.get());
			if (state.get()) {
				self.set_class_name("CoffeeDrunk");
				(self.get_child() as Astal.Icon).icon = "caffeine-cup-full";
				inhibitId.set(App.inhibit(null, Gtk.ApplicationInhibitFlags.IDLE, "Too excited to sleep."));
			} else {
				self.set_class_name("CoffeeZzz");
				(self.get_child() as Astal.Icon).icon = "sleep";
				App.uninhibit(inhibitId.get());
			}
		}}
	>
		<icon icon="sleep" />
	</button>
}
