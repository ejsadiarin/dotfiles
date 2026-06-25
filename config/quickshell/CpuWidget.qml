import QtQuick
import Quickshell.Io

Item {
    id: root
    property real usage: 0
    property string label: "CPU"

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

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
            text: Math.round(root.usage) + "%"
            color: Theme.textColor
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
        }
    }

    // Read /proc/stat twice with 1s interval to calculate usage
    property var prevIdle: 0
    property var prevTotal: 0

    function readStat() {
        statProc.running = true;
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: readStat()
    }

    Process {
        id: statProc
        command: ["head", "-1", "/proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                // line: cpu user nice system idle iowait irq softirq steal
                const parts = data.trim().split(/\s+/).slice(1).map(Number);
                const idle = parts[3];
                const total = parts.reduce((a, b) => a + b, 0);

                const diffIdle = idle - root.prevIdle;
                const diffTotal = total - root.prevTotal;

                if (diffTotal > 0) {
                    root.usage = ((diffTotal - diffIdle) / diffTotal) * 100;
                }

                root.prevIdle = idle;
                root.prevTotal = total;
            }
        }
    }
}
