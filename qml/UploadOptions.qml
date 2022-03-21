// Copyright (c) 2021 Aldo Hoeben / fieldOfView
// OctoPrintPlugin is released under the terms of the AGPLv3 or higher.

import QtQuick 2.1
import QtQuick.Controls 2.0

import UM 1.5 as UM
import Cura 1.0 as Cura

UM.Dialog
{
    id: uploadOptions

    title: catalog.i18nc("@action:button", "Upload to OctoPrint Options")

    minimumWidth: screenScaleFactor * 400
    minimumHeight: screenScaleFactor * 150

    buttonSpacing: UM.Theme.getSize("default_margin").width

    onAccepted: manager.acceptOptionsDialog()

    Column {
        anchors.fill: parent

        UM.I18nCatalog{id: catalog; name:"octoprint"}

        Grid
        {
            columns: 2
            width: parent.width
            verticalItemAlignment: Grid.AlignVCenter
            rowSpacing: UM.Theme.getSize("default_lining").height
            columnSpacing: UM.Theme.getSize("default_margin").width

            UM.Label
            {
                id: pathLabel
                text: catalog.i18nc("@label", "Path")
            }

            Cura.TextField {
                id: pathField
                text: manager.filePath
                maximumLength: 256
                width: parent.width - Math.max(pathLabel.width, fileLabel.width) - UM.Theme.getSize("default_margin").width
                horizontalAlignment: TextInput.AlignLeft
                validator: RegExpValidator
                {
                    regExp: /.*/
                }
                onTextChanged: manager.filePath = text
            }

            UM.Label
            {
                id: fileLabel
                text: catalog.i18nc("@label", "Filename")
            }

            Cura.TextField {
                id: nameField
                text: manager.fileName
                maximumLength: 100
                width: parent.width - Math.max(pathLabel.width, fileLabel.width) - UM.Theme.getSize("default_margin").width
                horizontalAlignment: TextInput.AlignLeft
                validator: RegExpValidator
                {
                    regExp: /[^\/]*/
                }
                onTextChanged: manager.fileName = text
            }
            Item
            {
                width: 1
                height: UM.Theme.getSize("default_margin").height
            }
            UM.Label
            {
                text: catalog.i18nc("@label", "A file extenstion will be added automatically.")
            }
        }

        Item
        {
            width: 1
            height: UM.Theme.getSize("default_margin").height
        }

        UM.CheckBox
        {
            id: autoPrintCheckBox
            text: catalog.i18nc("@label", "Start print job after uploading")
            checked: manager.autoPrint
            onClicked: manager.autoPrint = checked
        }
        UM.CheckBox
        {
            id: autoSelectCheckBox
            text: catalog.i18nc("@label", "Select print job after uploading")
            enabled: !autoPrintCheckBox.checked
            checked: autoPrintCheckBox.checked || manager.autoSelect
            onClicked: manager.autoSelect = checked
        }
    }

    rightButtons: [
        Cura.SecondaryButton {
            text: catalog.i18nc("@action:button", "Cancel")
            onClicked: uploadOptions.reject()
        },
        Cura.PrimaryButton {
            text: catalog.i18nc("@action:button", "OK")
            onClicked: uploadOptions.accept()
        }
    ]
}
