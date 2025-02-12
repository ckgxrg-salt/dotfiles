import { App, Astal } from "astal/gtk3";

import Buttons from "./Buttons";
import Dock from "./Dock";
import Media from "./Media";
import Workspaces from "./Workspaces";

export default function Dashboard(monitor: number) {
	const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;
	return <window
		application={App}
		className="Dashboard"
		monitor={monitor}
		exclusivity={Astal.Exclusivity.EXCLUSIVE}
		anchor={TOP | BOTTOM | LEFT | RIGHT
		}
	>
		<box>
			<box orientation={1}>
				<box>
					{Buttons()}
					{Workspaces()}
				</box>
				{Dock()}
			</box>
			{Media()}
		</box>
	</window>;
}
