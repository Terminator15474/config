import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.components.icons
import qs.components.colors
import qs.components.controls

import "."

RowLayout {
	Layout.alignment: Qt.AlignVCenter

	property string hour: hourTumbler.currentItem.text
	property string minute: minuteTumbler.currentItem.text

	property bool userInteracting: hourTumbler.moving || minuteTumbler.moving || userInteractionTimer.running

	spacing: -8

	Row {
		Layout.alignment: Qt.AlignVCenter

		Tumbler {
			id: hourTumbler
			model: 24
			visibleItemCount: 5
			height: 120
			width: 60

			flickDeceleration: 5000

			delegate: Text {
				text: modelData < 10 ? "0" + modelData : modelData
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				color: Colors.palette.fg

				opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
				font.pixelSize: Tumbler.isCurrentItem ? 24 : 16
			}

			MouseArea {
				anchors.fill: parent
				propagateComposedEvents: true

				onWheel: (wheel) => {
					userInteractionTimer.restart()

					if (wheel.angleDelta.y > 0) {
						hourTumbler.currentIndex = (hourTumbler.currentIndex - 1 + hourTumbler.count) % hourTumbler.count
					} else if (wheel.angleDelta.y < 0) {
						hourTumbler.currentIndex = (hourTumbler.currentIndex + 1) % hourTumbler.count
					}
					// Mark wheel event as accepted so PathView doesn't override it
					wheel.accepted = true
				}

				onPressed: (mouse) => {
					userInteractionTimer.restart()
					mouse.accepted = false
				}
			}
		}

	}
	Row {
		Text {
			text: ":"
			font.pixelSize: 24
			anchors.verticalCenter: parent.verticalCenter

			color: Colors.palette.fg
		}
	}
	Row {
		Tumbler {
			id: minuteTumbler
			model: 60
			visibleItemCount: 5
			height: 120
			width: 60

			Component.onCompleted: {
				this.positionViewAtIndex(new Date().getMinutes(), Tumbler.Center)
			}

			flickDeceleration: 5000

			delegate: Text {
				text: modelData < 10 ? "0" + modelData : modelData
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter

				color: Colors.palette.fg

				opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
				font.pixelSize: Tumbler.isCurrentItem ? 24 : 16
			}

			MouseArea {
				anchors.fill: parent
				propagateComposedEvents: true

				onWheel: (wheel) => {
					userInteractionTimer.restart()

					if (wheel.angleDelta.y > 0) {
						minuteTumbler.currentIndex = (minuteTumbler.currentIndex - 1 + minuteTumbler.count) % minuteTumbler.count
					} else if (wheel.angleDelta.y < 0) {
						minuteTumbler.currentIndex = (minuteTumbler.currentIndex + 1) % minuteTumbler.count
					}
					// Mark wheel event as accepted so PathView doesn't override it
					wheel.accepted = true
				}

				onPressed: (mouse) => {
					userInteractionTimer.restart()
					mouse.accepted = false
				}
			}
		}
	}

	ColumnLayout {
		id: alarms
		function startTimerAt(hour: string, minute: string): void {
			// notify-send is broken inside at
			// const alarm_finish_notif = `notify-send -u low -a "Alarm" "Alarm" "It is ${hour}:${minute}, you set an alarm for this time"`
			const alarm_sound =`mpv --no-video --audio-display=no --volume=75 --loop-playlist=2 /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga`

			const command = `${alarm_sound}`

			const now = new Date()
			const month = String(now.getMonth()+1).padStart(2, "0")
			const date = String(now.getDate()).padStart(2, "0")
			Quickshell.execDetached(["sh", "-c", `echo "${command}" | at -t ${month}${date}${hour}${minute}`])

			Quickshell.execDetached(["notify-send","-u", "low", "-a", "Alarm", "Alarm", `Scheduled alarm at ${hour}:${minute}`])
		}

		function startTimerIn(minutes: int):void {
			const startTime = new Date(Date.now() + minutes * 60_000);
			startTimerAt(startTime.getHours(), String(startTime.getMinutes()).padStart(2, "0"))
		}

		// Header
		Text {
			text: "Set Timer for..."
			font.pointSize: 12
			color: Colors.palette.fg
		}

		StyledButton {
			text: `${hour}:${minute} Uhr`
			Layout.fillWidth: true

			onClicked: {
				alarms.startTimerAt(hour, minute)
			}
		}

		StyledButton {
			text: "in 10 Minutes"
			Layout.fillWidth: true
			onClicked: {
				alarms.startTimerIn(10)
			}
		}

		StyledButton {
			text: "in 30 Minutes"
			Layout.fillWidth: true
			onClicked: {
				alarms.startTimerIn(30)
			}
		}

		StyledButton {
			text: "in 1 Hour"
			Layout.fillWidth: true
			onClicked: {
				alarms.startTimerIn(60)
			}
		}

	}

	Timer {
		id: updateTime

		interval: 30_000
		repeat: true
		running: true
		triggeredOnStart: true

		onTriggered: {
			if (!userInteracting) {
				hourTumbler.positionViewAtIndex(SystemClockHelper.hour, Tumbler.Center)
				minuteTumbler.positionViewAtIndex(SystemClockHelper.minute, Tumbler.Center)
			}
		}
	}

	Timer {
		id: userInteractionTimer
		interval: 10_000
	}
}
