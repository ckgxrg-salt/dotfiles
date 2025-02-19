import { App, Astal, Gtk, Gdk } from "astal/gtk3";

import Buttons from "./Buttons";
import Dock from "./Dock";
import Media from "./Media";
import Quote from "./Quote";
import Sliders from "./Sliders";
import Status from "./Status";
import Workspaces from "./Workspaces";

import { switchFocus } from "../util/hyprland";

export default function Dashboard(monitor: number) {
	const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

	return <window
		application={App}
		className="Dashboard"
		name="astal-dashboard"
		namespace="astal-dashboard"
		layer={Astal.Layer.BOTTOM}
		monitor={monitor}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		anchor={TOP | BOTTOM | LEFT | RIGHT}
		// Send cursor back to primary screen
		setup={self => {
			self.connect("touch-event", (_, event) => {
				if (event.get_event_type() === Gdk.EventType.TOUCH_END) {
					switchFocus();
				}
			})
		}}
	>
		<box
			className="DashboardContainer"
			halign={Gtk.Align.CENTER}
			valign={Gtk.Align.CENTER}
		>
			<Buttons />
			<box vertical>
				<Workspaces />
				<Quote />
				<Dock />
			</box>
			<Media />
			<box vertical>
				<Sliders />
				<Status />
			</box>
		</box>
	</window >;
}
