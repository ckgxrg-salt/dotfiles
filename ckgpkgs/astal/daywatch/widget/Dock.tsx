import { bind, Variable, execAsync } from "astal";
import Tray from "gi://AstalTray";

import { switch_focus } from "../util/hyprland";

export default function Dock() {
	return <box
		className="Dock"
	>
		<SysTray />
		<Memory />
	</box>;
}

function SysTray() {
	const tray = Tray.get_default();

	return <box className="SysTray">
		{bind(tray, "items").as(items => items.map(item => (
			<menubutton
				tooltipMarkup={bind(item, "tooltipMarkup")}
				usePopover={false}
				actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
				menuModel={bind(item, "menuModel")}>
				<icon gicon={bind(item, "gicon")} />
			</menubutton>
		)))}
	</box>
}

function Memory() {
	const memCmd = Variable(0).poll(5000, ["bash", "-c", "printf \"%.0f\\n\" $(free -m | grep Mem | awk '{print ($3 / $2 ) * 100}')"], (out) => parseInt(out));

	return <button className="Memory"
		onClicked={() => {
			switch_focus();
			execAsync("uwsm app -- alacritty -e btop");
		}}
	>
		{(memCmd())}
	</button>;
}
