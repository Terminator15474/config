import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.components
import qs.components.states
import qs.components.colors
import "services"

PanelWindow {
	id: root

	property bool actionsSelected: false

	property ScreenState screenState: ShellState.forMainScreen()

	visible: screenState.launcher

	implicitWidth: layout.implicitWidth + 24
	implicitHeight: layout.implicitHeight + 24

	color: Colors.palette.surface

	WlrLayershell.layer: WlrLayer.Overlay

	function close() {
		input.clear()
		screenState.launcher = false
	}

	function selectCurrent() {
		console.log("Selected something")
		const should_close = loader.item.executeSelected()
		if (should_close) {
			root.close()
		}
	}

	HyprlandFocusGrab {
		active: root.visible
		id: focusGrabber
		windows: [root]

		onCleared: root.close()
	}

	ColumnLayout {
		id: layout

		Keys.onEscapePressed: (event) => {
			root.close()
			event.accepted = true
		}

		Keys.onEnterPressed: (event) => {
			root.selectCurrent()
			event.accepted = true
		}

		Keys.onReturnPressed: (event) => {
			root.selectCurrent()
			event.accepted = true
		}

		Component {id: appsComponent; Apps {id: appSelector}}
		Component {id: actionsComponent; Actions {id: actionSelector}}

		Loader {
			id: loader
			sourceComponent: root.actionsSelected ? actionsComponent : appsComponent
		}

		Rectangle {
			id: inputBg
			color: Colors.palette.surface
			border.width: 2
			border.color: Colors.palette.bg

			TextInput {
				id: input

				focus: true

				horizontalAlignment: TextInput.AlignHCenter
				verticalAlignment: TextInput.AlignVCenter

				onTextEdited: () => {
					if (input.length === 1 && input.text[0] === ">") {
						console.log("Entered Action mode")
						root.actionsSelected = true
					} else if (input.text === "" && root.actionsSelected) {
						root.actionsSelected = false
					}
				}
			}
		}

		Binding {
			target: loader.item
			property: "searchString"
			value: input.text
		}
	}

}
