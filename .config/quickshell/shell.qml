//@ pragma UseQApplication
//@ pragma Env QS_ICON_THEME = Papirus

import QtQuick
import Quickshell
import Quickshell.Io
import "modules/bar"

ShellRoot {
	id: root

	FontLoader {
		id: nerdFonts
		source: "./assets/fonts/symbols-2048-em.ttf"
	}

	Bar {}
}
