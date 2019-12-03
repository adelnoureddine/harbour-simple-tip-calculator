# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-simple-tip-calculator

CONFIG += sailfishapp

SOURCES += src/harbour-simple-tip-calculator.cpp

DISTFILES += qml/harbour-simple-tip-calculator.qml \
    LICENSE \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-simple-tip-calculator.changes.in \
    rpm/harbour-simple-tip-calculator.changes.run.in \
    rpm/harbour-simple-tip-calculator.spec \
    rpm/harbour-simple-tip-calculator.yaml \
    harbour-simple-tip-calculator.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172
