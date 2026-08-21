pragma Singleton

import QtQuick
import Quickshell
import qs.components.config

Singleton {
	id: shellState

	property ShellRoot shellRoot

	function forScreen(screen: ShellScreen): ScreenState {
		for (const s of states.instances) {
			if (s.modelData === screen)	return s;
		}
		return null;
	}

	function forMainScreen(): ScreenState {
		const main = Config.config.screens.main;
		for (const s of states.instances) {
			if (s.modelData.name === main) return s;
		}
		return null
	}

	Variants {
		id: states
		model: Quickshell.screens

		ScreenState {}
	}
}
