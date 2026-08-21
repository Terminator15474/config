import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.components.colors
import qs.components.icons
import qs.components.states
import qs.fuzzy

Item {
	id: root

	property string searchString: ""

	property int selectedIndex: 0 // for future arrow controls inside
	property ScreenState screenState: ShellState.forMainScreen()
	property var filteredApps: Searcher.go(root.searchString, DesktopEntries.applications.values, "name", 0.5)

	implicitWidth: screenState.modelData.width * 0.2
	implicitHeight: screenState.modelData.height * 0.4

	function executeSelected(): bool {
		const selected = filteredApps[selectedIndex]
		if (selected.runInTerminal) {
			Quickshell.execDetached({
					command: ['tmux', 'new-window', '-n', `${selected.name}`, `"${selected.command.join(" ")}"`],
					workingDirectory: selected.workingDirectory
			})
		} else {
			selected.execute()
		}

		return true
	}

	ScrollView {
		anchors.fill: parent
		clip: true

		ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

		ColumnLayout  {
			id: wrapper
			width: parent.width
			spacing: 4

			Repeater {
				model: filteredApps
				Rectangle {
					id: itemBg

					required property var modelData
					required property int index

					Layout.fillWidth: true
					Layout.preferredHeight: 30

					color: index === selectedIndex ? Colors.palette.accent : Colors.palette.surface
					RowLayout {

						Text {
							id: appName
							text: modelData.name
							color: Colors.palette.fg
							Layout.fillWidth: true
						}
					}
				}
			}
		}
	}
}
