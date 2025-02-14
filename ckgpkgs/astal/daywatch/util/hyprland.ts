// Interacts with Hyprland
import Hyprland from "gi://AstalHyprland";
import Dashboard from "../widget/Dashboard";

const hypr = Hyprland.get_default();

// Manually summon the dashboard after suspend
export function awake() {
	hypr.connect("monitor-added", (_) => {
		Dashboard(1);
	})
}

// Switch the focus back to primary monitor before any task
export function switch_focus() {
	hypr.dispatch("focusmonitor", "eDP-1");
}
