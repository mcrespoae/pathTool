# pathTool
Scripts to convert paths from Windows to MacOS and vice versa.

## Before you start
*	Please, note that the audio scripts have been validated in **¡ macOS 10.13.6 and macOS 10.14.6**
*	Note that you may be asked to allow Automator or any other app you may use in the accessibility menu. To do so, open Settings, Security & Privacy and click on Privacy and then in Accessibility. Click the + button an add the Automator and Pro Tools app. You will have to allow more apps (Skype, Chrome, etc.)
* You will have to edit the paths inside the scripts to meet you needs.

## How to install the scripts
* Download the script you want to install fomr the *Automator* folder.
*	Double click on it. Once it has been installed, you may delete the local copy.
*	Open System Preferences and go to Keyboard. Then click on Shorcuts and Services. Into the General tab you will find the newly created Automator script. Add the shortcut and it will be done.
* The *Script* folder contains only the raw script. You don't need to use it.

## Available scripts
### Copy files and folders path
This script will convert macOS server paths into ready to use Windows paths. Also, it will open Skype so you can paste it. In order to use it, select one or more folder or files from the server and use the script. It will copy and transform the paths to your clipboard.
* Assign cmd+U.

### Convert text path
This script will convert macOS server paths into ready to use Windows paths or vice versa. If the original path is a macOS path it will also open Skype so you can paste it. If the original path is a Windows server path, it will open a finder folder with the converted path.

To use it, select a path as a text in any app. Then use the script. It will detect if the path is from the Windows or the macOS side and it will transform it automatically.
* Assign cmd+alt+ctrl+U.
