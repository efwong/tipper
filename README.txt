
# Pre-work - tipper

tipper is a tip calculator application for iOS.

Submitted by: Edwin Wong

Time spent: 12 hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [X] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [] List anything else that you can get done to improve the app functionality!
* [X] Added a splash screen
* [X] Added a simple app icon

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![Video Walkthrough](http://i.imgur.com/5ckd5iB.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

* Passing Data between views:  I wanted my main TipViewController to update total values returning from the SettingsViewTableController, but I couldn't find out how to have the TipViewController recognize that event.  Instead, I made the TipViewController implement an update delegate that the SettingsViewTableController would call to update total values.

* Understanding the view and app life cycle so that I can add specific events at the right time (eg. saving settings, time the app was closed)

## To Do

* Formatting the Bill value correctly: I want the bill textbox to restrict format to a currency format, and not allow multiple decimals or values with greater than 2 decimal places. This is still a work in progress.

* First text input should clear textbox: Because of the formatting issue above (always adding .00 to the end of the input), when the keyboard first pops up, if the previous value had decimals (eg. $10.00), the next keypress would add a number to the end of the textbox, but I would rather it clear the input and insert a new value.


## License

    Copyright [2016] [Edwin Wong]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.