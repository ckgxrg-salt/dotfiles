import { Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import { bind, Variable } from "astal";

const mpris = Mpris.get_default();
const activePlayer = Variable<Mpris.Player | undefined>(undefined);
mpris.connect('player-added', (_, addedPlayer) => {
	if (activePlayer.get() === undefined) {
		activePlayer.set(addedPlayer);
	}
});
mpris.connect('player-closed', (_, closedPlayer) => {
	if (mpris.get_players().length === 1 && closedPlayer.busName === mpris.get_players()[0]?.busName) {
		return activePlayer.set(undefined);
	}

	if (closedPlayer.busName === activePlayer.get()?.busName) {
		const nextPlayer = mpris.get_players().find((player) => player.busName !== closedPlayer.busName);
		activePlayer.set(nextPlayer);
	}
});

export default function Media() {
	activePlayer.set(mpris.get_players().find(player => player.get_can_play()) || undefined);
	return <box vertical className="Media">
		{Switchers()}
		{bind(activePlayer).as(player => {
			if (player === undefined) {
				return <label>No Players Found</label>;
			} else {
				return <PlayerControl player={player} />;
			}
		})}
	</box>;
}

// Switches between players
function nextPlayer() {
	let list = mpris.get_players().filter(player => player.get_can_play());
	let index = list.findIndex(player => player === activePlayer.get());
	if (index === list.length - 1) {
		activePlayer.set(list[0]);
	} else {
		activePlayer.set(list[index + 1]);
	}
}
function prevPlayer() {
	let list = mpris.get_players().filter(player => player.get_can_play());
	let index = list.findIndex(player => player === activePlayer.get());
	if (index === 0) {
		activePlayer.set(list[list.length - 1]);
	} else {
		activePlayer.set(list[index - 1]);
	}
}
function Switchers() {
	return <centerbox className="Switchers">
		<button onClicked={() => prevPlayer()}>
			<icon icon="media-skip-backward-symbolic" />
		</button>
		<label truncate label={bind(activePlayer).as(player => player?.get_identity())} />
		< button onClicked={() => nextPlayer()}>
			<icon icon="media-skip-forward-symbolic" />
		</button>
	</centerbox >;
}

// Controls MPRIS itself
function lengthStr(length: number) {
	const min = Math.floor(length / 60)
	const sec = Math.floor(length % 60)
	const sec0 = sec < 10 ? "0" : ""
	return `${min}:${sec0}${sec}`
}

function PlayerControl({ player }: { player: Mpris.Player }) {
	const { START, CENTER, END } = Gtk.Align;
	const title = bind(player, "title").as(t => t || "");
	const artist = bind(player, "artist").as(a => a || "");
	const coverArt = bind(player, "coverArt").as(c => `background-image: url('${c}')`);
	const position = bind(player, "position").as(p => player.length > 0 ? p / player.length : 0);
	const playIcon = bind(player, "playbackStatus").as(s => s === Mpris.PlaybackStatus.PLAYING ? "media-playback-pause-symbolic" : "media-playback-start-symbolic");

	return <box className="MediaPlayer" vertical>
		<box>
			<box className="CoverArt" css={coverArt} />
			<box vertical valign={CENTER} className="Title">
				<label truncate maxWidthChars={20} halign={START} label={title} />
				<label halign={START} valign={START} wrap label={artist} />
			</box>
		</box>
		<slider
			className="Progress"
			visible={bind(player, "length").as(l => l > 0)}
			onDragged={({ value }) => player.position = value * player.length}
			value={position}
		/>
		<centerbox className="Actions">
			<label
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
				halign={END}
				visible={bind(player, "length").as(l => l > 0)}
				label={bind(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
			/>
		</centerbox>
	</box >
}
