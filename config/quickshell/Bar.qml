import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Theme.barHeight
            color: Theme.bgColor

            RowLayout {
                anchors.fill: parent
                anchors.margins: Theme.barMargins
                spacing: Theme.barSpacing

                // Left: label
                Text {
                    text: "@dwin"
                    color: Theme.textColor
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                }

                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.fillHeight: true
                    Layout.margins: 4
                    color: Theme.separator
                }

                // System info widgets
                CpuWidget {}

                MemWidget {}

                // Spacer
                Item {
                    Layout.fillWidth: true
                }

                // Clock
                ClockWidget {}
            }
        }
    }
}
