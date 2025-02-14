import { App } from "astal/gtk3";
import style from "./css/style.scss";

import Dashboard from "./widget/Dashboard";

App.start({
	css: style,
	main() {
		Dashboard(1);
	},
});
