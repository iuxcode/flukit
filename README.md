# Flukit

A package for quick flutter developpement app

## Features

* Screens: There are plenty screens that are designed to help you go faster
* Widgets: useful widgets are designed for quick dev
* Utils

## Getting started

First at all, you need to make some modifications to your `android/app/build.gradle`

```gradle
 // some code

 android {
    compileSdkVersion 33
 }
 // another code

 defaultConfig {
  minSdkVersion 18
 }
 
 // and another code
```

then you can setup your app

```dart

void main() => runApp(FlukitApp);

class FlukitApp extends StatelessWidget {
 Widget build(BuildContext context) => FluMaterialApp();
}

```

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
