import { Astal, Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import { bind } from "astal";

export default function Media() {
	const mpris = Mpris.get_default();
	mpris.get_players().map(player => console.log(player.get_title()));
	return <box
		className="Media"
	>
		{bind(mpris, "players").as(arr => arr.map(player => (
			<MprisControl player={player} />
		)))}
	</box>;
}

function defaultPlayer(mpris: Mpris.Mpris) {
	let arr = mpris.get_players();
	if (arr.length > 0) {
		return <MprisControl player={arr[0]} />;
	} else {
		return "No Players";
	}
}

function lengthStr(length: number) {
	const min = Math.floor(length / 60)
	const sec = Math.floor(length % 60)
	const sec0 = sec < 10 ? "0" : ""
	return `${min}:${sec0}${sec}`
}

function MprisControl({ player }: { player: Mpris.Player }) {
	const { START, END } = Gtk.Align;
	const title = bind(player, "title").as(t => t || "Unknown Track");
	const artist = bind(player, "artist").as(a => a || "Unknown Artist");
	const coverArt = bind(player, "coverArt").as(c => `background-image: url('${c}')`);
	const playerIcon = bind(player, "entry").as(e => (e != null && Astal.Icon.lookup_icon(e)) ? e : "audio-x-generic-symbolic");
	const position = bind(player, "position").as(p => player.length > 0 ? p / player.length : 0);
	const playIcon = bind(player, "playbackStatus").as(s => s === Mpris.PlaybackStatus.PLAYING ? "media-playback-pause-symbolic" : "media-playback-start-symbolic");

	return <box className="MediaPlayer">
		<box className="CoverArt" css={coverArt} />
		<box vertical>
			<box className="Title">
				<label truncate hexpand halign={START} label={title} />
				<icon icon={playerIcon} />
			</box>
			<label halign={START} valign={START} vexpand wrap label={artist} />
			<slider
				visible={bind(player, "length").as(l => l > 0)}
				onDragged={({ value }) => player.position = value * player.length}
				value={position}
			/>
			<centerbox className="Actions">
				<label
					hexpand
					className="Position"
					halign={START}
					visible={bind(player, "length").as(l => l > 0)}
					label={bind(player, "position").as(lengthStr)}
				/>
				<box>
					<button
						onClicked={() => player.previous()}
						visible={bind(player, "canGoPrevious")}>
						<icon icon="media-skip-backward-symbolic" />
					</button>
					<button
						onClicked={() => player.play_pause()}
						visible={bind(player, "canControl")}>
						<icon icon={playIcon} />
					</button>
					<button
						onClicked={() => player.next()}
						visible={bind(player, "canGoNext")}>
						<icon icon="media-skip-forward-symbolic" />
					</button>
				</box>
				<label
					className="Length"
					hexpand
					halign={END}
					visible={bind(player, "length").as(l => l > 0)}
					label={bind(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
				/>
			</centerbox>
		</box>
	</box>
}
