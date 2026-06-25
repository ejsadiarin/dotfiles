import QtQuick
import Quickshell
import Quickshell.Io

property int memUsage: 0

Process {
    id: memProc
    command: ["free", "-h"]
    stdout: SplitParser {
        onRead: data => {
            // TODO: parse here
            var parts = ...
        }
    }
}
