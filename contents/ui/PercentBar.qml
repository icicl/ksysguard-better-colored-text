import QtQuick 2.9
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.1

Rectangle {
    id: percentBar
    property double percent
    property color color
    property string place
    property int parent_w
    property int parent_h

	property int bar_height: 3
	property bool place_horiz: place === "bottom" || place ==="top"

    readonly property int barWidth: controller.faceConfiguration.barWidth
    readonly property bool invertBarFill: controller.faceConfiguration.invertBarFill

    width: place_horiz ? parent_w : barWidth
    height: place_horiz ? barWidth : parent_h
    color: "transparent"

    Rectangle {
        width: place_horiz ? percentBar.parent_w : percentBar.barWidth
        height: place_horiz ? percentBar.barWidth : percentBar.parent_h
        color: Qt.rgba(percentBar.color.r, percentBar.color.g, percentBar.color.b, 0.3);
		anchors.left: parent.left
        anchors.bottom: parent.bottom

	Rectangle {
        width: place_horiz ? percentBar.parent_w * percentBar.percent : percentBar.barWidth
        height: place_horiz ? percentBar.barWidth : percentBar.parent_h * percentBar.percent
        color: percentBar.color
        anchors.left: percentBar.invertBarFill ? undefined : parent.left
        anchors.bottom: percentBar.invertBarFill ? undefined : parent.bottom
        anchors.right: percentBar.invertBarFill ? parent.right: undefined
        anchors.top: percentBar.invertBarFill ? parent.top : undefined
    }

    }

}
