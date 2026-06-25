import QtQuick
import Quickshell.Io

Item {
    id: root
    property real used: 0
    property real total: 0
    property string label: "Mem"

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    readonly property string usedStr: {
        if (used >= 1024)
            return (used / 1024).toFixed(1) + "GB";
        return Math.round(used) + "MB";
    }

    readonly property string totalStr: {
        if (total >= 1024)
            return (total / 1024).toFixed(1) + "GB";
        return Math.round(total) + "MB";
    }

    Row {
        id: row
        spacing: 4

        Text {
            text: root.label + ":"
            color: Theme.textColor
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }

        Text {
            text: root.usedStr + "/" + root.totalStr
            color: Theme.textColor
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: memProc.running = true
    }

    Process {
        id: memProc
        command: ["grep", "-E", "^(MemTotal|MemAvailable)", "/proc/meminfo"]
        stdout: SplitParser {
            onRead: data => {
                const parts = data.trim().split(/\s+/);
                const key = parts[0];
                const kb = parseInt(parts[1]);

                if (key === "MemTotal:")
                    root.total = kb / 1024;
                else if (key === "MemAvailable:")
                    root.used = root.total - (kb / 1024);
            }
        }
        Component.onCompleted: running = true
    }
}
