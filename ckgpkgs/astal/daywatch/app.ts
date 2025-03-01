import { App } from "astal/gtk3";
import style from "./css/style.scss";

import Dashboard from "./widget/Dashboard";
import { awake } from "./util/hyprland";

App.start({
	css: style,
	main() {
		awake();
		Dashboard(1);
	},
});
