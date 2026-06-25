pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root
    // Colors
    readonly property color bgColor: "#0E0E14"
    readonly property color textColor: "#c0caf5"
    readonly property color separator: "#3b4261"

    // Font
    readonly property string fontFamily: "IosevkaTerm Nerd Font"
    readonly property int fontSize: 14

    // Spacing
    readonly property int barHeight: 20
    readonly property int barSpacing: 8
    readonly property int barMargins: 2
    readonly property int iconSize: 24
}
