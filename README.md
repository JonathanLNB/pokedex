# Pokédex

Zipdev Flutter Code Assessment 

## Installation

1) Download SDK de [Flutter](https://flutter.dev/docs/get-started/install). 

2) Add Flutter to the PATH.

### Windows

```bash
This PC -> right click to properties -> Advanced system settings -> Environment variables in the variable called as Path. If there is no variable named as Path then create one and set the flutter/bin path.
```

### Mac & Linux

```bash
export PATH=/”flutter path”/bin:$PATH

echo $PATH
```

## Run App (Android)

 1) Download the dependencies.

```flutter
cd pokedex
flutter pub get
```

2) Run the app.

```flutter
flutter run
```

## Run App (iOS)

1) Open XCode.
2) First you will need to locate the **Runner.xcworkspace** file inside the ios folder of your project folder.
3) After that you can click run and build the project.

## Other run options
Also if there is an IDE such as Android Studio or VS Code, the instructions to follow are [specified here](https://flutter-es.io/docs/get-started/editor?tab=androidstudio)
