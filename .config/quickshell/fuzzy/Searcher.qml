pragma Singleton

import Quickshell
import "fuzzysort.js" as Fuzzysort

Singleton {
	function go(search, targets, key, threshold) {
		if (!search) return targets;

		// targets.forEach(t => t.prepared = Fuzzysort.prepare(t[key])) // Prepare for performance
		return Fuzzysort.go(search, targets, {key: key, threshold: threshold}).map(r => r.obj)
	}
}
