import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property double price: 0.0;
    property double tip_percentage;
    property double tip;
    property double total_price: 0.0;
    property string price_text;
    property string tip_text;
    property string total_text;

    function calculate() {
        if (priceField.text === "") {
            price = 0.0
            tip_percentage = 0.0
            tip = 0.0
            total_price = 0.0
            price_text = ""
            tip_text  = ""
            total_text = ""
        } else {
            var price_val = priceField.text
            if (price_val.indexOf(",") !== -1) {
                price_val = price_val.replace(",", ".")
            }
            price = price_val

            tip_percentage = tipField.value
            tip = price * (tip_percentage / 100)
            total_price = price + tip

            price_text = "Price: " + price.toFixed(2);
            tip_text = "Tip of " + tip_percentage + "%: " + tip.toFixed(2);
            total_text = "Total amount: " + total_price.toFixed(2);
        }
    }

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Simple Tip Calculator")
            }

            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: "Simple Tip Calculator"
            }

            // Price
            TextField {
                id: priceField
                width: page.width
                label: "Price"
                placeholderText: "Price"
                validator: RegExpValidator { regExp: /^\d+([\.|,]\d{1,2})?$/ }
                color: Theme.primaryColor
                inputMethodHints: Qt.ImhDigitsOnly
                EnterKey.enabled: text.length > 0
            }

            // Tip
            /*TextField {
                id: tipField
                width: page.width
                label: "Tip in %"
                placeholderText: "Tip in %"
                validator: RegExpValidator { regExp: /^(\d{1,2})(\.\d{1,2})?$/}
                color: Theme.primaryColor
                inputMethodHints: Qt.ImhDigitsOnly
                EnterKey.enabled: text.length > 0
            }*/

            Slider {
                id: tipField
                width: page.width
                minimumValue: 0
                maximumValue: 100
                value: 15
                valueText: value + "%"
                stepSize: 1
                label: "Tip"
            }

            Button {
                id: calculationButton
                text: "Calculate Tip"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked:calculate()
            }

            // Price
            // Tip
            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: price_text
                font.pixelSize: Theme.fontSizeLarge
            }

            // Tip
            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: tip_text
                font.pixelSize: Theme.fontSizeLarge
            }

            // Tip
            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: total_text
                font.pixelSize: Theme.fontSizeLarge
            }

            Label {
                id: separatorLabel
                x: Theme.horizontalPageMargin
                width: parent.width  - ( 2 * Theme.horizontalPageMargin )
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.Wrap
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
