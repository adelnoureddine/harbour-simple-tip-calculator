import QtQuick 2.0
import Sailfish.Silica 1.0

/*
 * One line of the result: what it is on the left, the amount on the right.
 */
Item {
    id: row

    property alias label: labelText.text
    property alias value: valueText.text
    property alias valueFontSize: valueText.font.pixelSize
    property alias valueColor: valueText.color

    width: parent ? parent.width : 0
    height: Math.max(labelText.height, valueText.height)

    Label {
        id: labelText
        anchors.left: parent.left
        anchors.right: valueText.left
        anchors.rightMargin: Theme.paddingMedium
        anchors.baseline: valueText.baseline
        truncationMode: TruncationMode.Fade
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.secondaryColor
    }

    Label {
        id: valueText
        anchors.right: parent.right
        width: Math.min(implicitWidth, row.width * 0.65)
        horizontalAlignment: Text.AlignRight
        truncationMode: TruncationMode.Fade
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.primaryColor
    }
}

// vim:et:ts=4:sw=4
