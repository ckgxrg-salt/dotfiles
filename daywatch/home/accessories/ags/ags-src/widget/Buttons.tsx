export default function Buttons() {
	return <box
		orientation={1}
		className="Buttons"
	>
		{AppsButton()}
		{PowerButton()}
	</box>;
}

function AppsButton() {
	return <button
		className="AppsButton"
		onClicked="uwsm app -- rofi -show drun"
	>
		
	</button>;
}
function PowerButton() {
	return <button
		className="PowerButton"
		onClicked="uwsm app -- wlogout"
	>
		󰐥
	</button>;
}
