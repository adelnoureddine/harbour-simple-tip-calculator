import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: page

    allowedOrientations: Orientation.All

    readonly property string sourceUrl: "https://github.com/adelnoureddine/harbour-simple-tip-calculator"
    readonly property string licenseUrl: "https://www.gnu.org/licenses/gpl-3.0.html"
    // Set by the C++ launcher. Undefined when the page is loaded without it (qmlscene).
    readonly property string version: typeof appVersion !== "undefined" ? String(appVersion) : ""
    readonly property real contentWidth: Math.min(width, Screen.width)

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        Column {
            id: column

            anchors.horizontalCenter: parent.horizontalCenter
            width: page.contentWidth
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("About")
            }

            // The app icon, name and version.
            Column {
                width: parent.width
                spacing: Theme.paddingSmall

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: Theme.iconSizeExtraLarge
                    height: width
                    sourceSize.width: width
                    sourceSize.height: height
                    fillMode: Image.PreserveAspectFit
                    // The launcher icon installed with the app (SAILFISHAPP_ICONS).
                    source: "/usr/share/icons/hicolor/172x172/apps/harbour-simple-tip-calculator.png"
                }

                Label {
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    //: The app's full name
                    text: qsTr("Simple Tip Calculator")
                    font.pixelSize: Theme.fontSizeExtraLarge
                    color: Theme.primaryColor
                }

                Label {
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    visible: page.version !== ""
                    text: qsTr("Version %1").arg(page.version)
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryHighlightColor
                }

                Item { width: 1; height: Theme.paddingMedium }

                Label {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * Theme.horizontalPageMargin
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("Work out the tip and the total of a bill in a few taps.")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryColor
                }
            }

            Card {
                Label {
                    width: parent.width
                    wrapMode: Text.Wrap
                    text: qsTr("Author and maintainer")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryHighlightColor
                }

                Label {
                    width: parent.width
                    wrapMode: Text.Wrap
                    text: "Adel Noureddine © 2019-2026"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                }
            }

            SectionHeader {
                text: qsTr("Source code")
            }

            Column {
                width: parent.width
                spacing: Theme.paddingMedium

                LinkRow {
                    title: qsTr("View source code")
                    detail: page.sourceUrl.replace("https://", "")
                    url: page.sourceUrl
                    icon: "image://theme/icon-m-developer-mode"
                }

                LinkRow {
                    //: Link to the text of the app's software license
                    title: qsTr("License")
                    detail: qsTr("Licensed under the GNU GPL 3 license only (GPL-3.0-only)")
                    url: page.licenseUrl
                    icon: "image://theme/icon-m-document"
                }
            }
        }

        VerticalScrollDecorator {}
    }
}

// vim:et:ts=4:sw=4
