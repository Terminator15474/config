//@ pragma UseQApplication
//@ pragma Env QS_ICON_THEME = Papirus

import QtQuick
import Quickshell
import Quickshell.Io
import "modules/bar"
import "modules/background"
import "modules/launcher"
import qs.components.states
import qs.components

ShellRoot {
	id: root

	Binding {
		target: ShellState
		property: "shellRoot"
		value: root
	}

	FontLoader {
		id: nerdFonts
		source: "./assets/fonts/GoogleSansFlex-VariableFont_GRAD,ROND,opsz,slnt,wdth,wght.ttf"
	}

	Shortcuts {}

	Background {}

	Bar {}

	Launcher {}
}
