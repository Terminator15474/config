import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Mpris

import qs.components.colors
import qs.components.icons
import qs.components.states

Item {
	id: root

	required property PanelWindow barRoot

	implicitHeight: compact.implicitHeight
	implicitWidth: compact.implicitWidth

	height: implicitHeight
	width: implicitWidth

	property var activePlayer: {
		return Mpris.players.values.find(p => p.playbackState === MprisPlaybackState.Playing)
		|| Mpris.players.values[0]
		|| null;
	}

	visible: activePlayer != null

	RowLayout {
		id: compact

		Text {
			text: activePlayer?.trackTitle ?? "Nothing Playing"
			color: Colors.palette.fg
		}
	}

	MouseArea {
		anchors.fill: parent
		onClicked: {
			ShellState.forMainScreen().mediaPlayer = !ShellState.forMainScreen().mediaPlayer
		}
	}

	TapHandler {
		id: tapHandler

		gesturePolicy: TapHandler.WithinBounds
		onTapped: {
			ShellState.forMainScreen().mediaPlayer = !ShellState.forMainScreen().mediaPlayer
		}
	}

	HoverHandler {
		id: hoverHandler
		onHoveredChanged: () => {
			activePlayer?.positionChanged() // Update position
			if(!hoverHandler.hovered && !popupHover.hovered && !ShellState.forMainScreen().mediaPlayer) {
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

		visible: ShellState.forMainScreen().mediaPlayer || hoverHandler.hovered || popupHover.hovered || hideTimer.running

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
				spacing: 12

				Layout.alignment: Qt.AlignHCenter

				Text {
					text: root.activePlayer?.trackTitle ?? "No Track"
					font.pointSize: 10
					color: Colors.palette.fg
					Layout.alignment: Qt.AlignHCenter
				}

				Text {
					text: "by " + activePlayer?.trackArtist ?? ""
					font.pointSize: 8
					color: Colors.palette.fg
					Layout.alignment: Qt.AlignHCenter
				}

				RowLayout {
					id: controls

					visible: activePlayer?.canControl ?? false

					Layout.alignment: Qt.AlignHCenter

					// Shuffle
					ClickableIcon {
						id: shuffleIcon

						visible: activePlayer?.shuffleSupported ?? false

						icon: activePlayer?.shuffle ? "online/media-playlist-shuffle-enabled" : "online/media-playlist-shuffle"
						color: Colors.palette.fg

						onClicked: {
							if (activePlayer) activePlayer.shuffle = !activePlayer.shuffle
						}
					}

					ClickableIcon {
						id: prevIcon

						visible: activePlayer?.canGoPrevious ?? false

						icon: "papirus/media-skip-backward-symbolic"
						color: Colors.palette.fg
						size: 16

						onClicked: activePlayer?.previous()
					}

					ClickableIcon {
						id: playPauseIcon

						visible: activePlayer?.canTogglePlaying ?? false

						icon: activePlayer?.isPlaying ? "online/media-playback-pause" : "online/media-playback-start"
						color: Colors.palette.fg
						size: 16

						onClicked: activePlayer?.togglePlaying()
					}

					ClickableIcon {
						id: nextIcon

						visible: activePlayer?.canGoNext ?? false

						icon: "papirus/media-skip-forward-symbolic"
						color: Colors.palette.fg
						size: 16

						onClicked: activePlayer?.next()
					}

					ClickableIcon {
						id: loopIcon

						visible: activePlayer?.loopSupported ?? false

						icon: {
							if (activePlayer?.loopState === MprisLoopState.None) return "online/media-playlist-repeat";
							if (activePlayer?.loopState === MprisLoopState.Playlist) return "online/media-playlist-repeat-playlist";
							if (activePlayer?.loopState === MprisLoopState.Track) return "online/media-playlist-repeat-track";
							return "papirus/error"
						}

						color: Colors.palette.fg
						size: 16

						onClicked: () => {
							if (activePlayer?.loopState === MprisLoopState.None) { activePlayer.loopState = MprisLoopState.Playlist}
							else if (activePlayer?.loopState === MprisLoopState.Playlist) { activePlayer.loopState = MprisLoopState.Track}
							else if (activePlayer?.loopState === MprisLoopState.Track) { activePlayer.loopState = MprisLoopState.None}
						}
					}
				}

				RowLayout {
					id: seekBarLayout
					Layout.alignment: Qt.AlignHCenter

					visible: true

					function displayTime(length: real): string {
						if (length >= 3600) {
							let hours = Math.trunc(length / 3600);
							let minutes = Math.trunc((length % 3600) / 60)
							let secons = Math.trunc((length % 60))

							return hours
							+ ":"
							+ String(minutes).padStart(2, "0")
							+ ":"
							+ String(secons).padStart(2, "0");
						}

						let minutes = Math.trunc(length / 60)
						let secons = Math.trunc((length % 60))

						return minutes + ":" + String(secons).padStart(2, "0")
					}

					Text {
						id: trackTimeLeft
						visible: activePlayer?.positionSupported ?? false

						text: seekBarLayout.displayTime(activePlayer?.position ?? 0)
						color: Colors.palette.fg
					}

					Slider {
						id: seekBar

						visible: (activePlayer?.positionSupported && activePlayer?.lengthSupported) ?? false

						from: 0
						to: (activePlayer?.length > 0) ? (activePlayer?.length ?? 0) : 1
						value: seekBar.pressed ? value : (activePlayer?.position ?? 0)

						background: Rectangle {
							x: seekBar.leftPadding
							y: seekBar.topPadding + seekBar.availableHeight / 2 - height / 2

							implicitWidth: 200
							width: seekBar.availableWidth
							height: 5

							radius: 2

							color: Colors.palette.accent

							Rectangle {
								width: seekBar.visualPosition * parent.width
								height: parent.height

								color: Colors.palette.bg

								topLeftRadius: 2
								bottomLeftRadius: 2
							}
						}

						handle: Rectangle {
							x: seekBar.leftPadding + seekBar.visualPosition * (seekBar.availableWidth - width)
							y: seekBar.topPadding + seekBar.availableHeight / 2 - height / 2

							implicitWidth: 8
							implicitHeight: 8
							radius: 4
							color: Colors.palette.bg
						}

						onPressedChanged: {
							if(!pressed) {
								activePlayer.position = seekBar.value
							}
						}
					}

					Text {
						id: trackTime
						visible: activePlayer?.lengthSupported ?? false

						text: seekBarLayout.displayTime(activePlayer?.length ?? 0)
						color: Colors.palette.fg
					}
				}

				RowLayout {
					id: playerSelector

					Layout.alignment: Qt.AlignHCenter

					// Left
					ClickableIcon {
						icon: "online/go-previous"

						visible: Mpris.players.values.length > 1

						onClicked: {
							let activeIndex = Mpris.players.values.indexOf(activePlayer)

							if(activePlayer?.canPause) {
								activePlayer.pause()
							} else if (activePlayer?.canStop) {
								activePlayer.stop()
							}

							activePlayer = Mpris.players.values[(activeIndex-1) % Mpris.players.values.length]

							if(activePlayer?.canPlay) {
								activePlayer.play()
							} else if (activePlayer?.canRaise) {
								activePlayer.raise() // If we can't play, bring it forward for the user to start playing
							}
						}
					}

					Repeater {
						model: Mpris.players

						Text {
							visible: modelData?.identity === activePlayer.identity

							text: modelData.identity
							color: Colors.palette.fg
						}
					}

					ClickableIcon {
						icon: "online/go-next"

						visible: Mpris.players.values.length > 1

						onClicked: {
							let activeIndex = Mpris.players.values.indexOf(activePlayer)
							activePlayer?.canPause ? activePlayer.pause() : activePlayer.stop()
							activePlayer = Mpris.players.values[(activeIndex+1) % Mpris.players.values.length]
							activePlayer?.canPlay ? activePlayer.play() : null
						}
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
		onTriggered: activePlayer?.positionChanged()
	}
}
