pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root

	readonly property string minute: clock.minutes
	readonly property string hour: clock.hours

	readonly property string time: {
		Qt.formatDateTime(clock.date, "hh:mm")
	}

	readonly property string date: {
		Qt.formatDateTime(clock.date, "dd/MM")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
