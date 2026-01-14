import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.2 as Controls

import org.kde.kirigami 2.8 as Kirigami

import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.ksysguard.faces 1.0 as Faces

Kirigami.FormLayout {
    id: root

	property alias cfg_autoRange: autoRangeCheckbox.checked
	property alias cfg_rangeFrom: rangeFromSpin.value
	property alias cfg_rangeFromMultiplier: rangeFromSpin.multiplier
	property alias cfg_rangeTo: rangeToSpin.value
	property alias cfg_rangeToMultiplier: rangeToSpin.multiplier
	property alias cfg_enableColorGradient: enableColorGradientCheckbox.checked
	property alias cfg_colorGradientFrom: colorGradientFromColorbox.color
	property alias cfg_colorGradientTo: colorGradientToColorbox.color
	property alias cfg_showBar: showBarCheckbox.checked
	property string cfg_barPosition: controller.faceConfiguration.barPosition
	property string cfg_textMode: controller.faceConfiguration.textMode
	property alias cfg_fontsize: fontsizeSpin.value
	property alias cfg_barWidth: barWidthSpin.value
	property alias cfg_gap: gapSpin.value
	property alias cfg_minwidth: minwidthSpin.value

	Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    ColumnLayout {
        Kirigami.FormData.label: "Data"
		spacing: 10
		Layout.alignment: Qt.AlignHCenter
        Controls.CheckBox {
			id: autoRangeCheckbox
            text: i18n("Auto data range")
        }

        Row {
			spacing: 20
            Controls.Label {
                text: i18n("Range from: ")
            }
            Faces.SensorRangeSpinBox {
				id: rangeFromSpin
                value: rangeFrom
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				sensors: controller.totalSensors
				width: 100
				enabled: !cfg_autoRange
            }
        }
        Row {
			spacing: 20
            Controls.Label {
                text: i18n("Range to:   ")
            }
			Faces.SensorRangeSpinBox {
				id: rangeToSpin
				value: rangeTo
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				sensors: controller.totalSensors
				width: 100
				enabled: !cfg_autoRange
			}
        }
	}

	Kirigami.Separator {
        Kirigami.FormData.isSection: true
    }

	ColumnLayout {
        Kirigami.FormData.label: "Color"
		spacing: 10
        Controls.CheckBox {
			id: enableColorGradientCheckbox
            text: i18n("Enable color gradient")
        }
        Row {
            Controls.Label {
                text: i18n("Color gradient from: ")
            }
			Rectangle{
				id: colorGradientFromColorbox
				color: colorGradientFrom
				width: Kirigami.Theme.defaultFont.pointSize * 1.5
				height: Kirigami.Theme.defaultFont.pointSize * 1.5
				border.color: "grey"
				border.width: 1
				radius: 3
				visible: true
				MouseArea {
					anchors.fill: parent
					onClicked: fromColorDialog.open()
				}
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				enabled: cfg_enableColorGradient
			}
			ColorDialog {
				id: fromColorDialog
				title: i18n("Please choose a color")
				color: cfg_colorGradientFrom
				onAccepted: {
					cfg_colorGradientFrom = fromColorDialog.color
				}
				visible: false
				modality: Qt.WindowModal
			}
        }
        Row {
			Controls.Label {
				text: i18n("Color gradient to:   ")
			}
			Rectangle{
				id: colorGradientToColorbox
				color: colorGradientTo
				width: Kirigami.Theme.defaultFont.pointSize * 1.5
				height: Kirigami.Theme.defaultFont.pointSize * 1.5
				border.color: "grey"
				border.width: 1
				radius: 3
				visible: true
				MouseArea {
					anchors.fill: parent
					onClicked: toColorDialog.open()
				}
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				enabled: cfg_enableColorGradient
			}
			ColorDialog {
				id: toColorDialog
				title: i18n("Please choose a color")
				color: cfg_colorGradientTo
				onAccepted: {
					cfg_colorGradientTo = toColorDialog.color
				}
				visible: false
				modality: Qt.WindowModal
			}
        }
	}

	Kirigami.Separator {
        Kirigami.FormData.isSection: true
    }

	ColumnLayout {
        Kirigami.FormData.label: "Bar"
		spacing: 10
        Controls.CheckBox {
			id: showBarCheckbox
			text: i18n("Show bar")
		}

		Controls.ButtonGroup {
            id: typeGroup
        }
        Controls.RadioButton {
            text: "bottom"
            checked: cfg_barPosition == this.text
			enabled: cfg_showBar
            Controls.ButtonGroup.group: typeGroup
            onCheckedChanged: {
                if (checked) {
                    cfg_barPosition = this.text
                }
            }
        }
        Controls.RadioButton {
            text: "right"
            Controls.ButtonGroup.group: typeGroup
            checked: cfg_barPosition == this.text
			enabled: cfg_showBar
            onCheckedChanged: {
                if (checked) {
                    cfg_barPosition = this.text
                }
            }
        }
        Controls.RadioButton {
            text: "top"
            Controls.ButtonGroup.group: typeGroup
            checked: cfg_barPosition == this.text
			enabled: cfg_showBar
            onCheckedChanged: {
                if (checked) {
                    cfg_barPosition = this.text
                }
            }
        }
        Controls.RadioButton {
            text: "left"
            Controls.ButtonGroup.group: typeGroup
            checked: cfg_barPosition == this.text
			enabled: cfg_showBar
            onCheckedChanged: {
                if (checked) {
                    cfg_barPosition = this.text
                }
            }
        }
	}

	Kirigami.Separator {
		Kirigami.FormData.isSection: true
	}

	ColumnLayout {
		Kirigami.FormData.label: "Size"
		spacing: 10
		Layout.alignment: Qt.AlignHCenter

		Row {
			spacing: 20
			Controls.Label {
				text: i18n("Font size: ")
			}
			Controls.SpinBox {
				id: fontsizeSpin
				value: fontsize
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				width: 100
			}
		}

		Row {
			spacing: 20
			Controls.Label {
				text: i18n("Bar width: ")
			}
			Controls.SpinBox {
				id: barWidthSpin
				value: barWidth
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				width: 100
			}
		}

		Row {
			spacing: 20
			Controls.Label {
				text: i18n("Gap: ")
			}
			Controls.SpinBox {
				id: gapSpin
				value: gap
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				width: 100
			}
		}

		Row {
			spacing: 20
			Controls.Label {
				text: i18n("Min Width: ")
			}
			Controls.SpinBox {
				id: minwidthSpin
				from: 0
				to: 1000
				value: minwidth
				Layout.preferredWidth: Kirigami.Units.gridUnit * 10
				width: 100
			}
		}
	}

	Kirigami.Separator {
		Kirigami.FormData.isSection: true
	}

	ColumnLayout {
		Kirigami.FormData.label: "Text Display"
		spacing: 8
		Layout.alignment: Qt.AlignHCenter

		Controls.ButtonGroup {
			id: textModeGroup
		}

		// BOTH
		Controls.RadioButton {
			property string value: "both_label_first"
			text: "Label + Value (Label first)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}
		Controls.RadioButton {
			property string value: "both_value_first"
			text: "Label + Value (Value first)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}

		Kirigami.Separator { }

		// LABEL ONLY
		Controls.RadioButton {
			property string value: "label_left"
			text: "Label only (Left)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}
		Controls.RadioButton {
			property string value: "label_center"
			text: "Label only (Center)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}
		Controls.RadioButton {
			property string value: "label_right"
			text: "Label only (Right)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}

		Kirigami.Separator { }

		// VALUE ONLY
		Controls.RadioButton {
			property string value: "value_left"
			text: "Value only (Left)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}
		Controls.RadioButton {
			property string value: "value_center"
			text: "Value only (Center)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}
		Controls.RadioButton {
			property string value: "value_right"
			text: "Value only (Right)"
			Controls.ButtonGroup.group: textModeGroup
            checked: cfg_textMode == this.value
            onCheckedChanged: {
                if (checked) {
                    cfg_textMode = this.value
                }
            }
		}
	}
}
