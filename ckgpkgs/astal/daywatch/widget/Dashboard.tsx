import { App, Astal, Gtk } from "astal/gtk3";

import Buttons from "./Buttons";
import Dock from "./Dock";
import Media from "./Media";
import Sliders from "./Sliders";
import Status from "./Status";
import Workspaces from "./Workspaces";

export default function Dashboard(monitor: number) {
	const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

	return <window
		application={App}
		className="Dashboard"
		namespace="astal-dashboard"
		layer={Astal.Layer.BOTTOM}
		monitor={monitor}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		anchor={TOP | BOTTOM | LEFT | RIGHT}
	>
		<box
			className="DashboardContainer"
			halign={Gtk.Align.CENTER}
			valign={Gtk.Align.CENTER}
		>
			<Buttons />
			<box vertical>
				<Workspaces />
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
