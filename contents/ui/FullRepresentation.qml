import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1

import org.kde.kirigami 2.8 as Kirigami

import org.kde.ksysguard.faces 1.0 as Faces
import org.kde.ksysguard.sensors 1.0 as Sensors

Faces.SensorFace {
    id: root
    readonly property var primarySensorIds: {
        if (controller.highPrioritySensorIds && controller.highPrioritySensorIds.length > 0) {
            return controller.highPrioritySensorIds
        }

        if (controller.sensorIds && controller.sensorIds.length > 0) {
            return controller.sensorIds
        }

        return []
    }
    readonly property var secondarySensorIds: {
        if (controller.lowPrioritySensorIds && controller.lowPrioritySensorIds.length > 0) {
            return controller.lowPrioritySensorIds
        }

        return []
    }
    contentItem: ColumnLayout {
        Kirigami.Heading {
            Layout.alignment: Qt.AlignHCenter
            text: controller.title
            visible: controller.showTitle
            level: 2
        }

        TotalSensor {}

        Sensors.SensorDataModel {
            id: sensorModel
            sensors: root.primarySensorIds
            sensorColors: controller.sensorColors
        }

       Faces.ExtendedLegend {
            sourceModel: sensorModel
            sensorIds: root.secondarySensorIds
            Layout.fillWidth: true
        }
    }
    Layout.minimumWidth: controller.faceConfiguration.minwidthFull
}
