import Battery from "gi://AstalBattery";
import { Variable, bind, GLib } from "astal";
import { Gtk } from "astal/gtk3";

export default function Status() {
	return <box
		className="Status"
		vertical
	>
		<Clock />
		<Bat />
	</box>;
}

function Clock({ format = "%H:%M - %A %e." }) {
	const time = Variable<string>("").poll(1000, () =>
		GLib.DateTime.new_now_local().format(format)!);

	return <box
		className="Clock"
		onDestroy={() => time.drop()}
		halign={Gtk.Align.CENTER}
		valign={Gtk.Align.CENTER}
	>
		{time()}
	</box>;
}

function Bat() {
	const bat = Battery.get_default();

	return <box className="Battery"
		visible={bind(bat, "isPresent")}
		halign={Gtk.Align.CENTER}
		valign={Gtk.Align.CENTER}
	>
		<icon
			icon={bind(bat, "batteryIconName")}
		/>
		<label
			label={bind(bat, "percentage").as(p => `${Math.floor(p * 100)} %`)}
		/>
	</box>;
}
