import { App } from "astal/gtk3";
import style from "./style.scss";

import Dashboard from "./widget/Dashboard";

App.start({
	css: style,
	main() {
		Dashboard(1);
	},
});
