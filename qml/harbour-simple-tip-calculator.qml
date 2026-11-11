import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "js/tip.js" as Tip

/*
 * The bill and the tip live here rather than on the page, so the cover shows the same
 * result as the page.
 */
ApplicationWindow {
    id: appWindow

    // What is typed in the bill field.
    property string billText: ""
    // A whole percentage, 0 to 50.
    property int tipPercent: 15
    // {bill, tip, total} in cents, null until a bill is typed.
    readonly property var result: Tip.compute(Tip.parseCents(billText), tipPercent)

    // An amount in cents, in the phone's currency and number format ("1,48 €", "$1.48").
    function money(cents) {
        return Number(cents / 100).toLocaleCurrencyString(Qt.locale());
    }

    function percentText(percent) {
        //: A tip percentage, %1 is the number. French writes "15 %" with a space.
        return qsTr("%1%").arg(percent);
    }

    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}

// vim:et:ts=4:sw=4
