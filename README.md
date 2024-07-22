<div style="display: flex; overflow-x: auto; white-space: nowrap; padding: 10px;">
  <img src="./screenshots/1.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/2.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/3.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/4.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/5.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/6.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/7.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/8.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
  <img src="./screenshots/9.png" alt="Image 1" style="height: 300px; margin-right: 10px;">
</div>

## App Features

- [x] Kanban board for tasks, where users can create, edit, and move tasks between different columns.
- [x] A timer function that allows users to start and stop tracking the time spent on each task. **⚠️ Local Only ⚠️**
- [x] A history of completed tasks, including the time spent on each task and the date it was completed.
- [x] Customisable themes: Allow users to customise the look and feel of the app by choosing from a selection of pre-defined color schemes.


## Getting Started

### Prerequisites

- Flutter 3.19.6
- Java 11
- Xcode 15.2.0
- Vscode or android studio with flutter and dart extensions installed

### Installation

If you're new to Flutter the first thing you'll need is to follow the [setup instructions](https://docs.flutter.dev/get-started/install).

### Debug Builds

- Use `flutter run -d DEVICE_ID` to deploy a test build
  To get a list of available `DEVICE_ID`, use `flutter run`.
- Typical values are: `windows`, `linux`, `macos`, `chrome`.
- Add `--release` to deploy an optimized build.

**Note:**

If you want to add your Todoist `apiKey` pass it as compile time constant for ex:
`flutter run --dart-define "apiKey={APIKEY}"`

Or you can change in `lib/config/constants.dart` file

### Release Builds

- Use `flutter build PACKAGE_TYPE` to build a release package.
- To get a list of available `PACKAGE_TYPE`, use `flutter build`.
- Typical values are  `apk` , `ios`.

## Screen


## Demo build

- Android : 

## Supported platforms

- [x] IOS
- [x] Android
