import QtQuick

Text {
	id: root

	property string icon: ""
	property real size: 18

	function codepointFromHexString(input: string): string {
		if (!input) return ""

		let parsedInt = Number.parseInt(input, 16)
		console.log(parsedInt)
		if(parsedInt < 0  || parsedInt > 0x10FFF ) return ""

		return String.fromCodePoint(parsedInt)
	}

	font.family: nerdFonts.name
	font.pixelSize: root.size
	text: codepointFromHexString(root.icon)

	renderType: Text.NativeRendering
	horizontalAlignment: Text.AlignHCenter
	verticalAlignment: Text.AlignVCenter
}
