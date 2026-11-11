import QtQuick 2.0
import Sailfish.Silica 1.0

/*
 * The total and the tip of what is on the page, without opening the app.
 */
CoverBackground {
    id: cover

    readonly property var result: appWindow.result

    Column {
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        width: parent.width - 2 * Theme.paddingLarge
        spacing: Theme.paddingMedium
        visible: cover.result !== null

        Label {
            width: parent.width
            truncationMode: TruncationMode.Fade
            //: Cover header: the app's short name and the tip percentage
            text: qsTr("Tip · %1").arg(appWindow.percentText(appWindow.tipPercent))
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.highlightColor
        }

        Column {
            width: parent.width

            Label {
                width: parent.width
                truncationMode: TruncationMode.Fade
                text: qsTr("Total")
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
            }
            Label {
                width: parent.width
                text: cover.result ? appWindow.money(cover.result.total) : ""
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: Theme.fontSizeSmall
                font.pixelSize: Theme.fontSizeExtraLarge
                color: Theme.primaryColor
            }
        }

        Column {
            width: parent.width

            Label {
                width: parent.width
                truncationMode: TruncationMode.Fade
                text: qsTr("Tip")
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
            }
            Label {
                width: parent.width
                text: cover.result ? appWindow.money(cover.result.tip) : ""
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: Theme.fontSizeExtraSmall
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
            }
        }
    }

    CoverPlaceholder {
        visible: cover.result === null
        //: Cover text before a bill is entered: the app's name
        text: qsTr("Tip Calculator")
        icon.source: "/usr/share/icons/hicolor/86x86/apps/harbour-simple-tip-calculator.png"
    }
}

// vim:et:ts=4:sw=4
