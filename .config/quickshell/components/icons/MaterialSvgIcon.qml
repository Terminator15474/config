import QtQuick
import QtQuick.Layouts

SvgIcon {
	id: root

	required property string iconName

	property string weight: "400"
	property string style: "rounded"

	Layout.preferredWidth: root.size
	Layout.preferredHeight: root.size

	icon: ["material", weight, style, iconName].join("/")
}
