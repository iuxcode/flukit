# Flukit

Flukit is a versatile and easy-to-use Flutter mini framework inpired by [Get](https://pub.dev/packages/get) that simplifies app development. With Flukit, you can easily manage routing, theming, and utilities, as well as take advantage of pre-designed widgets and shortcuts to streamline your Flutter projects.

## :rocket: Introduction

Welcome to `Flukit`, a powerful toolkit designed to simplify the app development process for Flutter developers. Our goal is to provide an efficient and streamlined solution for common app development tasks, including routing, theming, utilities, and widgets.

Developing apps can be complex and time-consuming, and our framework is here to make your life easier. This mini framework aim to empower developers by offering a set of tools that enhance productivity and provide a better development experience.

Whether you're building a small project or a complex application, this Flutter Mini Framework is here to help you achieve your goals faster and with less effort.

## :sparkles: Features

- **Pre-designed widgets** like buttons, avatars, screens, images, etc.
- **Routing**: Just define a bunch of pages and you're good to go.
- **Theming**: Customize your app's appearance effortlessly with a flexible theming system that allows you to create unique designs.
- **Utilities**: Access a set of handy utility functions that streamline common development tasks.
- **Shortcuts**: Save time and reduce boilerplate code with prebuilt shortcuts and code snippets for common tasks.

## :construction: Getting started

To use `flukit` in your Flutter project, add the following dependency to your pubspec.yaml:

```yaml
dependencies:
  flukit:
    git:
      url: https://github.com/charles9904/flukit
```

Then run ```bash flutter packages get``` in your terminal to install the package.

## :fire: Usage

To use Flukit in your project, import the package and use any of the provided widgets or utilities. For example, to use the flukit Button widget:

```dart
FluButton(
  onPressed: () {
    // Handle button press.
  },
  text: 'Press me',
),
```

For more information and examples, please see the documentation (Coming Soon).

## :link: Widgets

- [App](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/app.dart)
- [Avatar group](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/avatar_group.dart)
- [Avatar](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/avatar.dart)
- [Badge](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/badge.dart)
- [Bottom navigation bar](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/bottom_navigation.dart)
- [Bottom sheet](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/bottom_sheet.dart)
- [Button](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/button.dart)
- [Chip](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/chip.dart)
- [Collapsible](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/collapsible.dart)
- [Country selector](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/country_selector.dart)
- [Dashed circle](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/dashed_circle.dart)
- [Divider](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/divider.dart)
- [Glass](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/glass.dart)
- [Grid](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/grid.dart)
- [Image](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/image.dart)
- [Text input](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/inputs.dart)
- [Loader](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/loader.dart)
- [Loader](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/loader.dart)
- [Outline](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/outline.dart)
- [Page view notifier](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/page_view.dart)
- [Tabs indicators](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/widgets/tabs.dart)

## :iphone: Screens

- [Basic screen](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/screens/base.dart)
- [Nav](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/screens/navigation.dart)
- [404](https://github.com/iuxcode/flukit/blob/main/lib/src/ui/screens/not_found.dart)

## :wrench: Services

- [Local storage](https://github.com/iuxcode/flukit/blob/main/lib/src/services/local_storage.dart)
- [Location](https://github.com/iuxcode/flukit/blob/main/lib/src/services/location.dart)

## :bulb: Utilities

- [BuildContext] extensions

  - `context.mediaQuerySize`: equivalent of MediaQuery.of(context).size
  - `context.height`: equivalent of MediaQuery.of(context).size.height
  - `context.width`: equivalent of MediaQuery.of(context).size.width
  - `context.heightTransformer`: Gives you the power to get a portion of the screen height.
  - `context.widthTransformer`: Gives you the power to get a portion of the screen width.
  - `context.ratio`: Divide the height proportionally by the given value.
  - `context.theme`: similar to [Theme.of(context)]
  - `context.colorScheme`: similar to [Theme.of(context).colorScheme]
  - `context.textTheme`: similar to [Theme.of(context).textTheme]
  - `context.isDarkMode`: Check if dark mode theme is enabled
  - `context.iconColor`: give access to [Theme.of(context).iconTheme.color]
  - `context.systemUiOverlayStyle`: Set a [SystemUiOverlayStyle] based on the provided [ThemeData]
  - `context.mediaQuery`: similar to [MediaQuery.of(context)]
  - `context.mediaQueryPadding`: similar to [MediaQuery.of(context).padding]
  - `context.mediaQueryViewPadding`: similar to [MediaQuery.of(context).viewPadding]
  - `context.mediaQueryViewInsets`: similar to [MediaQuery.of(context).viewInsets]
  - `context.orientation`: similar to [MediaQuery.of(context).orientation]
  - `context.statusBarHeight`: return [MediaQuery.of(context).padding.top]
  - `context.isKeyboardHidden`: Check if the keyboard is visible or not
  - `context.alwaysUse24HourFormat`: similar to [MediaQuery.of(context).alwaysUse24HourFormat]
  - `context.isLandscape`: check if device is on landscape mode
  - `context.isPortrait`: check if device is on portrait mode
  - `context.devicePixelRatio`: similar to [MediaQuery.of(this).devicePixelRatio]
  - `context.textScaleFactor`: similar to [MediaQuery.of(this).textScaleFactor]
  - `context.mediaQueryShortestSide`: get the shortestSide from screen
  - `context.showNavbar`: True if width be larger than 800
  - `context.isPhoneOrLess`: True if the width is smaller than 600p
  - `context.isPhoneOrWider`: True if the width is higher than 600p
  - `context.isPhone`: True if the shortestSide is smaller than 600p
  - `context.isSmallTabletOrLess`: True if the width is smaller than 600p
  - `context.isSmallTabletOrWider`: True if the width is higher than 600p
  - `context.isSmallTablet`: True if the shortestSide is largest than 600p
  - `context.isLargeTablet`: True if the shortestSide is largest than 720p
  - `context.isLargeTabletOrLess`: True if the width is smaller than 720p
  - `context.isLargeTabletOrWider`: True if the width is higher than 720p
  - `context.isTablet`: True if the current device is Tablet
  - `context.isDesktopOrLess`: True if the width is smaller than 1200p
  - `context.isDesktopOrWider`: True if the width is higher than 1200p
  - `context.isDesktop`: same as [isDesktopOrLess]

- [num] extensions

  - `[num].isLowerThan`
  - `[num].isGreaterThan`
  - `[num].isEqual`
  - `[num].toPositive`
  - `[num].isLowerThan`
  - `[num].delay`: Utility to delay some callback. [Read more](https://github.com/iuxcode/flukit/blob/main/lib/src/utils/extensions/duration.dart)

- [double] or [int] extensions

  - `[double / int].milliseconds` or `double.ms`: double to milliseconds [Duration]
  - `[double / int].seconds`: double to seconds [Duration]
  - `[double / int].minutes`: double to minutes [Duration]
  - `[double / int].hours`: double to hours [Duration]
  - `[double / int].days`: double to days [Duration]

- [Durations] extensions

  - `[Duration].delay`: Utility to delay some callback. [Read more](https://github.com/iuxcode/flukit/blob/main/lib/src/utils/extensions/duration.dart)

- [List] extensions

  - `[List].addIf`: Add element to list if condition is respected

- [String] extensions

  - `[String].isNum`: Discover if the String is a valid number
  - `[String].isNumericOnly`: Discover if the String is numeric only
  - `[String].isAlphabetOnly`: Discover if the String is alphanumeric only
  - `[String].isBool`: Discover if the String is a boolean
  - `[String].isVectorFileName`: Discover if the String is a vector
  - `[String].isImageFileName`: Discover if the String is a ImageFileName
  - `[String].isAudioFileName`: Discover if the String is a AudioFileName
  - `[String].isVideoFileName`: Discover if the String is a VideoFileName
  - `[String].isTxtFileName`: Discover if the String is a TxtFileName
  - `[String].isDocumentFileName`: Discover if the String is a Document Word
  - `[String].isExcelFileName`: Discover if the String is a Document Excel
  - `[String].isPPTFileName`: Discover if the String is a Document Powerpoint
  - `[String].isAPKFileName`: Discover if the String is a APK File
  - `[String].isPDFFileName`: Discover if the String is a PDF file
  - `[String].isHTMLFileName`: Discover if the String is a HTML file
  - `[String].isURL`: Discover if the String is a URL file
  - `[String].isEmail`: Discover if the String is a Email
  - `[String].isPhoneNumber`: Discover if the String is a Phone Number
  - `[String].isDateTime`: Discover if the String is a DateTime
  - `[String].isMD5`: Discover if the String is a MD5 Hash
  - `[String].isSHA1`: Discover if the String is a SHA1 Hash
  - `[String].isSHA256`: Discover if the String is a SHA256 Hash
  - `[String].isBinary`: Discover if the String is a bynary value
  - `[String].isIPv4`: Discover if the String is a ipv4
  - `[String].isIPv6`: Discover if the String is a ipv6
  - `[String].isHexadecimal`: Discover if the String is a Hexadecimal
  - `[String].isPalindrom`: Discover if the String is a palindrom
  - `[String].isPassport`: Discover if the String is a passport number
  - `[String].isCurrency`: Discover if the String is a currency
  - `[String].isCpf`: Discover if the String is a CPF number
  - `[String].isCnpj`: Discover if the String is a CNPJ number
  - `[String].isCaseInsensitiveContains`: Discover if the String is a case insensitive
  - `[String].isCaseInsensitiveContainsAny`: Discover if the String is a case sensitive and contains any value
  - `[String].capitalize`: capitalize the String
  - `[String].capitalizeFirst`: Capitalize the first letter of the String
  - `[String].removeAllWhitespace`: remove all whitespace from the String
  - `[String].camelCase`: converter the String
  - `[String].paramCase`: Discover if the String is a valid URL
  - `[String].createPath`: add segments to the String
  - `[String].capitalizeAllWordsFirstLetter`: capitalize only first letter in String words to upper case

- Platform

  - `Flu.isWeb`
  - `Flu.isMacOS`
  - `Flu.isWindows`
  - `Flu.isLinux`
  - `Flu.isAndroid`
  - `Flu.isIOS`
  - `Flu.isFuchsia`
  - `Flu.isMobile`
  - `Flu.isDesktop`

- Connectivity (pre-alpha)

  - `Flu.deviceIsOnline`
  - `Flu.getDeviceConnectivity`
  - `Flu.listenToDeviceConnectivityChange`

- Trigger haptic

  - `Flu.triggerSelectionClickHaptic`
  - `Flu.triggerVibrationHaptic`
  - `Flu.triggerLightImpactHaptic`
  - `Flu.triggerMediumImpactHaptic`
  - `Flu.triggerHeavyImpactHaptic`

- Validators

  - `Flu.validatePhoneNumber`
  - `Flu.validateEmail`

- Parsers

  - `Flu.dataFromBase64String`: Decodes [base64] or [base64url] encoded bytes.

- Helpers
  
  - `M3FontSizes`: Material design 3 recommended font sizes.
  - `Countries`: List of countries. [Read more](https://github.com/iuxcode/flukit/blob/main/lib/src/utils/countries.dart)
  - `Flu.numberToCompactFormat`: A number format for compact representations, e.g. "1.2M" instead of "1,200,000".
  - `Flu.textToAvatarFormat`
  - `Flu.hideKeyboard`
  - `Flu.showKeyboard`
  - `Flu.getAvatar`
  - `Flu.showFluModalBottomSheet`
  - `Flu.showCountrySelector`

- Date time
  
  - `Flu.dateTimeFromTimestamp`: Get DateTime from timestamp
  - `Flu.timeFromDateTime`: Get only the time from a datetime.
  - `Flu.formatDate`: Creates a new DateFormat, using the format specified by [pattern]
  - `Flu.timeago`: Formats provided [date] to a fuzzy time like 'a moment ago'
  - `Flu.timeFromSeconds`: Get time from seconds
  - `Flu.timeLeft`
  - `Flu.formatDuration`

- Navigation

  - `to`: Pushes a new `page` to the stack
  - `toNamed`: Pushes a new named `page` to the stack.
  - `offNamed`: Pop the current named `page` in the stack and push a new one in its place
  - `until`: Calls pop several times in the stack until [predicate] returns true
  - `offUntil`: Push the given `page`, and then pop several pages in the stack until [predicate] returns true
  - `offNamedUntil`: Push the given named `page`, and then pop several pages in the stack until [predicate] returns true
  - `offAndToNamed`: Pop the current named page and pushes a new `page` to the stack in its place
  - `removeRoute`: Remove a specific [route] from the stack
  - `offAllNamed`: Push a named `page` and pop several pages in the stack until [predicate] returns true. [predicate] is optional
  - `back`: Pop the current page, snackbar, dialog or bottomsheet in the stack
  - `close`: Close as many routes as defined by [times]
  - `off`: Pop the current page and pushes a new `page` to the stack
  - `offAll`: Push a `page` and pop several pages in the stack until [predicate] returns true. [predicate] is optional
  - `cleanRouteName`: Takes a route name String generated, cleans the extra chars and accommodates the format. Eg: `() => MyHomeScreenView` becomes `/my-home-screen-view`.
  - `focusScope`: give access to FocusScope.of(context)

## :v: Contributing

Contributions to Flukit are welcome and encouraged! To contribute, please fork the repository and submit a pull request. Please make sure to read the [Contributing Guide](https://github.com/charles9904/flukit/blob/main/CONTRIBUTING.md) before making a pull request.

- What needs to be done:

  - Write a documentation
  - Write & setup tests
  - Optimize the code
  - Add more widget & utilities

## :page_with_curl: License

Flukit is licensed under the MIT License.
