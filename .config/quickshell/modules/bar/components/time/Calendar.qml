import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.components.icons
import qs.components.colors

GridLayout {
	columns: 2

	DayOfWeekRow {
		locale: grid.locale

		Layout.column: 1
		Layout.fillWidth: true

		delegate: Text {
			text: shortName
			color: Colors.palette.fg

			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter

			required property string shortName
		}
	}

	WeekNumberColumn {
		month: grid.month
		year: grid.year
		locale: grid.locale

		Layout.fillHeight: true

		delegate: Text {
			text: weekNumber
			color: Colors.palette.fg

			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter

			required property int weekNumber
		}
	}

	MonthGrid {
		id: grid
		locale: Qt.locale("de_DE")
		Layout.fillWidth: true
		Layout.fillHeight: true

		delegate: Text {
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			opacity: model.month === grid.month ? 1 : 0
			text: grid.locale.toString(model.date, "d")
			color: model.today ? Colors.palette.fg : Colors.palette.accent
			font.bold: model.today

			required property var model
		}
	}
}
