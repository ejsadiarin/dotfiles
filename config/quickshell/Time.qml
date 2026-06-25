pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM d  h:mm AP");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
