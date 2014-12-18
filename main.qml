/*
 * (C) Copyright 2014 Blagovest Petrov <blagovest@petrovs.info>.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: mainWindow

    property string clocktext : "00:00:00"
    property string backcolor
    property real shift
    property int hours
    property int seconds
    property int minutes
//    width: 800
//    height: 600
    width: clocklabel.implicitWidth * 2
    height: clocklabel.implicitHeight * 2
    visible: true

    FontLoader { id: textfont; source:"OpenSans-Bold.ttf" }

     function timeChanged()  {
         var tday = new Date;
         hours = shift ? tday.getUTCHours() + Math.floor(clock.shift) : tday.getHours();
         minutes = shift ? tday.getUTCMinutes() + ((clock.shift % 1) * 60) : tday.getMinutes();
         seconds = tday.getUTCSeconds();
         clocktext = hours + ":" + minutes + ":" + seconds;
         backcolor = "#" + hours + minutes + seconds;

     }

     Timer  {
            interval: 100; running: true; repeat: true;
            onTriggered: mainWindow.timeChanged()
        }

    Rectangle {
        id: mainrect
//        width: parent.width
//        height: parent.height
        anchors.fill: parent

        color: backcolor
        Text {
            Rectangle { anchors.fill: parent; opacity: 0.5; color: "red" }
            id:clocklabel
            text: clocktext
            anchors.centerIn: parent
            color: "white"
            font {
                family: textfont.name
                pointSize: 56
                capitalization: Font.AllLowercase
            }
        }
    }
}
