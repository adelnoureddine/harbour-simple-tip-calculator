import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

/*
 * The calculator: the bill, the tip percentage, and the result, which follows both as
 * they change (version 0.2 needed a Calculate button and then showed stale results).
 */
Page {
    id: page

    allowedOrientations: Orientation.All

    // Lines stay a readable length in landscape and on tablets.
    readonly property real contentWidth: Math.min(width, Screen.width)
    readonly property var presets: [10, 15, 18, 20, 25]
    readonly property string currencySymbol: Qt.locale().currencySymbol(Locale.CurrencySymbol)

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.animatorPush(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        Column {
            id: column

            anchors.horizontalCenter: parent.horizontalCenter
            width: page.contentWidth
            spacing: Theme.paddingLarge

            PageHeader {
                //: The app's name, as the page title
                title: qsTr("Tip Calculator")
            }

            TextField {
                id: billField
                width: parent.width
                label: page.currencySymbol !== ""
                       //: Bill field label, %1 is the currency symbol such as "€"
                       ? qsTr("Bill amount (%1)").arg(page.currencySymbol)
                       : qsTr("Bill amount")
                placeholderText: label
                // The digits keypad has no decimal separator, so cents could not be typed.
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegExpValidator { regExp: /^\d{1,9}([.,]\d{0,2})?$/ }
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false
                onTextChanged: appWindow.billText = text
            }

            Column {
                width: parent.width
                spacing: Theme.paddingMedium

                Label {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * Theme.horizontalPageMargin
                    text: qsTr("Tip")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                }

                // The usual percentages, one tap each; the slider covers the rest.
                Row {
                    id: presetRow
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * Theme.horizontalPageMargin
                    spacing: Theme.paddingMedium

                    Repeater {
                        model: page.presets

                        BackgroundItem {
                            id: chip

                            readonly property bool selected: appWindow.tipPercent === modelData

                            width: (presetRow.width - (page.presets.length - 1) * presetRow.spacing) / page.presets.length
                            height: Theme.itemSizeSmall
                            highlightedColor: "transparent"
                            onClicked: tipSlider.value = modelData

                            CardBackground {
                                anchors.fill: parent
                                highlighted: chip.highlighted
                                primary: chip.selected
                            }

                            Label {
                                anchors.centerIn: parent
                                text: appWindow.percentText(modelData)
                                font.pixelSize: Theme.fontSizeSmall
                                font.bold: chip.selected
                                color: chip.highlighted ? Theme.highlightColor : Theme.primaryColor
                            }
                        }
                    }
                }

                Slider {
                    id: tipSlider
                    width: parent.width
                    minimumValue: 0
                    maximumValue: 50
                    stepSize: 1
                    label: qsTr("Tip percentage")
                    valueText: appWindow.percentText(Math.round(value))
                    onValueChanged: appWindow.tipPercent = Math.round(value)
                    Component.onCompleted: value = appWindow.tipPercent
                }
            }

            // The result, once there is a bill.
            Card {
                visible: appWindow.result !== null
                spacing: Theme.paddingMedium

                Column {
                    width: parent.width

                    Label {
                        width: parent.width
                        text: qsTr("Total")
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryHighlightColor
                    }

                    Label {
                        width: parent.width
                        text: appWindow.result ? appWindow.money(appWindow.result.total) : ""
                        // Long totals shrink rather than fade.
                        fontSizeMode: Text.HorizontalFit
                        minimumPixelSize: Theme.fontSizeLarge
                        font.pixelSize: Theme.fontSizeHuge
                        color: Theme.primaryColor
                    }
                }

                AmountRow {
                    //: Result line, %1 is the percentage such as "15%"
                    label: qsTr("Tip (%1)").arg(appWindow.percentText(appWindow.tipPercent))
                    value: appWindow.result ? appWindow.money(appWindow.result.tip) : ""
                    valueFontSize: Theme.fontSizeLarge
                    valueColor: Theme.highlightColor
                }

                AmountRow {
                    label: qsTr("Bill")
                    value: appWindow.result ? appWindow.money(appWindow.result.bill) : ""
                }
            }

            Card {
                visible: appWindow.result === null
                subtle: true

                Label {
                    width: parent.width
                    wrapMode: Text.Wrap
                    text: qsTr("Enter the bill amount to see the tip and the total.")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryColor
                }
            }
        }

        VerticalScrollDecorator {}
    }
}

// vim:et:ts=4:sw=4
