import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Mpris

import qs.components.colors
import qs.components.icons

Item {
	id: root

	required property PanelWindow barRoot

	implicitHeight: compact.implicitHeight
	implicitWidth: compact.implicitWidth

	height: implicitHeight
	width: implicitWidth

	readonly property var activePlayer: {
		return Mpris.players.values.find(p => p.playbackState === MprisPlaybackState.Playing)
		|| Mpris.players.values[0]
		|| null;
	}

	visible: activePlayer != null

	RowLayout {
		id: compact

		Text {
			text: activePlayer.trackTitle
			color: Colors.palette.fg
		}
	}

	HoverHandler {
		id: hoverHandler
		onHoveredChanged: () => {
			activePlayer.positionChanged() // Update position
			if(!hoverHandler.hovered && !popupHover.hovered) {
				hideTimer.start()
			}
		}
	}

	Timer {
		id: hideTimer
		interval: 150
		repeat: false
		running: false
	}

	PopupWindow {
		id: popup

		anchor.item: root
		anchor.edges: Edges.Bottom
		anchor.gravity: Edges.Bottom
		anchor.margins.top: 24

		implicitWidth: popupLayout.implicitWidth + 24
		implicitHeight: popupLayout.implicitHeight + 24

		visible: hoverHandler.hovered || popupHover.hovered || hideTimer.running

		color: "#00ffffff"

		Rectangle {
			id: contentBg
			anchors.fill: parent

			color: Colors.palette.surface
			border.color: Colors.palette.accent
			border.width: 1
			radius: 4

			HoverHandler {
				id: popupHover
			}

			ColumnLayout {
				id: popupLayout
				anchors.fill: parent
				anchors.margins: 12
				spacing: 6

				Layout.alignment: Qt.AlignHCenter

				Text {
					text: root.activePlayer?.trackTitle ?? "No Track"
					color: Colors.palette.fg
					Layout.alignment: Qt.AlignVCenter
				}

				// Artist

				RowLayout {
					id: controls

					visible: activePlayer.canControl

					Layout.alignment: Qt.AlignHCenter

					// Shuffle
					ClickableSvgIcon {
						id: shuffleIcon

						visible: activePlayer.shuffleSupported

						icon: activePlayer.shuffle ? "online/media-playlist-shuffle-enabled" : "online/media-playlist-shuffle"
						color: Colors.palette.fg

						onClicked: () => activePlayer.shuffle = !activePlayer.shuffle
					}

					ClickableSvgIcon {
						id: prevIcon

						visible: activePlayer.canGoPrevious

						icon: "online/media-skip-backward"
						color: Colors.palette.fg
						size: 16

						onClicked: activePlayer.previous()
					}

					ClickableSvgIcon {
						id: playPauseIcon

						visible: activePlayer.canTogglePlaying

						icon: activePlayer.isPlaying ? "online/media-playback-pause" : "online/media-playback-start"
						color: Colors.palette.fg
						size: 16

						onClicked: activePlayer.togglePlaying()
					}

					ClickableSvgIcon {
						id: nextIcon

						visible: activePlayer.canGoNext

						icon: "online/media-skip-forward"
						color: Colors.palette.fg
						size: 16

						onClicked: activePlayer.next()
					}

					ClickableSvgIcon {
						id: loopIcon

						visible: activePlayer.loopSupported

						icon: {
							if (activePlayer.loopState == MprisLoopState.None) return "online/media-playlist-repeat";
							if (activePlayer.loopState == MprisLoopState.Playlist) return "online/media-playlist-repeat-playlist";
							if (activePlayer.loopState == MprisLoopState.Track) return "online/media-playlist-repeat-track";
						}

						color: Colors.palette.fg
						size: 16

						onClicked: () => {
							if (activePlayer.loopState == MprisLoopState.None) activePlayer.loopState = MprisLoopState.Playlist;
							if (activePlayer.loopState == MprisLoopState.Playlist) activePlayer.loopState = MprisLoopState.Track;
							if (activePlayer.loopState == MprisLoopState.Track) activePlayer.loopState = MprisLoopState.None;
						}
					}

				}

				RowLayout {
					id: seekBarLayout
					Layout.alignment: Qt.AlignHCenter

					visible: true

					function displayTime(length: real): string {
						if (length >= 3600) {
							let hours = Math.round(length / 3600);
							let minutes = Math.round((length % 3600) / 60)
							let secons = Math.round((length % 60))

							return hours + ":" + String(minutes).padStart(2, "0") + ":" + String(secons).padStart(2, "0")
						}

						let minutes = Math.round(length / 60)
						let secons = Math.round((length % 60))

						return minutes + ":" + String(secons).padStart(2, "0")
					}

					Text {
						id: trackTimeLeft
						visible: activePlayer.positionSupported

						text: seekBarLayout.displayTime(activePlayer.position)
						color: Colors.palette.fg
					}

					Slider {
						id: seekBar

						visible: activePlayer.positionSupported && activePlayer.lengthSupported

						from: 0
						to: activePlayer.length
						value: activePlayer.position

						onMoved: () => {
							activePlayer.position = seekBar.value
							activePlayer.positionChanged()
						}
					}

					Text {
						id: trackTime
						visible: activePlayer.lengthSupported

						text: seekBarLayout.displayTime(activePlayer.length)
						color: Colors.palette.fg
					}

				}
			}
		}
	}
	Timer {
		id: positionUpdateTimer
		running: hoverHandler.hovered || popupHover.hovered || hideTimer.running
		interval: 1000
		repeat: true
		onTriggered: activePlayer.positionChanged()
	}
}

// Repeater {
// 	model: Mpris.players
//
// 	Text {
// 		visible: modelData.isPlaying || Mpris.players.values.length == 1
// 		text: modelData.identity
// 		color: Colors.palette.fg
// 	}
// }

// Idee:
// Anzeigen von Aktuellem track, aktueller player darunter mit < - > controls um zwischne player zu wechseln
// Aktueller player mit prev, play/pause, next buttons
