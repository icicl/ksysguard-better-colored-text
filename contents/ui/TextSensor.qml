import QtQuick 2.9
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.1

import org.kde.kirigami 2.8 as Kirigami
import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.ksysguard.faces 1.0 as Faces
import org.kde.quickcharts 1.0 as Charts
import org.kde.quickcharts.controls 1.0 as ChartControls
import org.kde.plasma.core 2.0 as PlasmaCore

RowLayout {

	property color actualColor 
    property string sensorValue
	property string sensorName
	// property int fixed_width
	readonly property int fontsize: controller.faceConfiguration.fontsize
    readonly property int minwidth: controller.faceConfiguration.minwidth
    readonly property string textMode: controller.faceConfiguration.textMode

	id: sensor
	Layout.fillHeight: true 
    Layout.fillWidth: true
    Layout.alignment : Qt.AlignHCenter | Qt.AlignTop
    
    // Layout.preferredWidth: fixed_width
    Layout.minimumWidth: sensor.minwidth
    // Layout.maximumWidth: fixed_width
    Controls.Label {
        Layout.alignment: (textMode == "label_right") ? Qt.AlignRight : (textMode == "label_center" ? Qt.AlignHCenter : Qt.AlignLeft)
        id: itemLabel
        visible: !(textMode == "value_left" || textMode == "value_center" || textMode == "value_right")
        color: actualColor
        z:1
        horizontalAlignment: Text.AlignHCenter
        text: (textMode != "both_value_first") ? sensorName : sensorValue
        font.pointSize: sensor.fontsize ||  Kirigami.Theme.defaultFont.pointSize * 0.8
        antialiasing : true        
    }
    Controls.Label {
        Layout.alignment: (textMode == "value_left") ? Qt.AlignLeft : (textMode == "value_center" ? Qt.AlignHCenter : Qt.AlignRight)
        id: itemValue
        visible: !(textMode == "label_left" || textMode == "label_center" || textMode == "label_right")
        color: actualColor
        z:1
        horizontalAlignment: Text.AlignHCenter
        text: (textMode != "both_value_first") ? sensorValue : sensorName
        font.pointSize: sensor.fontsize ||  Kirigami.Theme.defaultFont.pointSize * 0.8
        antialiasing : true        
    }
}
