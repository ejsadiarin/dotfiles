import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 4

    Text {
        text: Time.time
        color: Theme.textColor
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }
}
