# super_easy_permissions

A flutter plugin for handling permissions on Android/iOS in a super simple way.

Please support me via [Donation](https://paypal.me/riturajshakti). Your donation seriously motivates me to build many useful plugins like this.

## How to use

### Step 1:

First add this package in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  super_easy_permissions: any
```

Make sure to **GET** all the pub packages after saving this file.

### Step 2:

#### Android

Add the required permissions in your `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
```

In this case, I have added camera permission (which also require adding hardware feature). Your's case may be different. For example, You may require storage permissions.

**NOTE:** If you need to add storage permissions in `AndroidManifest.xml`, make sure to add the following line in manifest file:

```xml
<application
      android:requestLegacyExternalStorage="true"
      ...
```

For a list of all permissions, visit [`Google Developers`](https://developer.android.com/reference/android/Manifest.permission#summary) site.

#### iOS

Add required permissions in `Info.plist` file:

```xml
<key>NSCameraUsageDescription</key>
<string>$(PRODUCT_NAME) camera description.</string>
```

In this case, I have added camera permission. Your need may be different.
For a list of all permissions, visit [`Apple Developers`](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW1) site.

### Step 3

Import the library in your dart file:

```dart
import 'package:super_easy_permissions/super_easy_permissions.dart';
```

### Step 4

Finally, use the package

#### Check if permission is granted

```dart
bool result = await SuperEasyPermissions.isGranted(Permissions.camera);
if (result) {
  // Permission is granted, do something
}
```

#### Ask for permission

```dart
bool result = await SuperEasyPermissions.askPermission(Permissions.camera);
if (result) {
  // Permission is granted, do something
} else {
  // Permission denied, do something else
}
```

#### Check if permission is denied

```dart
bool result = await SuperEasyPermissions.isDenied(Permissions.camera);
if (result) {
  // Permission is denied, do something
}
```

## Permissions Reference

```dart
  Permissions.accessMediaLocation        // for android only
  Permissions.activityRecognition        // for android only
  Permissions.bluetooth
  Permissions.calendar
  Permissions.camera
  Permissions.contacts
  Permissions.ignoreBatteryOptimizations // for ios only
  Permissions.location
  Permissions.locationAlways
  Permissions.locationWhenInUse
  Permissions.mediaLibrary               // for ios only
  Permissions.microphone
  Permissions.notification
  Permissions.phone                      // for android only
  Permissions.photos                     // for ios only
  Permissions.photosAddOnly              // for ios only
  Permissions.reminders                  // for ios only
  Permissions.sensors
  Permissions.sms                        // for android only
  Permissions.speech
  Permissions.storage
```

## Other useful packages

- [super_easy_in_app_purchase](https://pub.dev/packages/super_easy_in_app_purchase)

## References

- [API docs of this package](https://pub.dev/documentation/super_easy_permissions/latest/super_easy_permissions/SuperEasyPermissions-class.html)
- [Complete example on github](https://github.com/riturajshakti/SuperEasyPermission/tree/main/example)

## Issues

Don't hesitate to email any issues or feature at <riturajshakti@gmail.com>.

## Want to contribute

**Please support me via [Donation](https://paypal.me/riturajshakti).
Your donation seriously motivates me to develop more useful packages like this.**

## Author

This Permission plugin for Flutter is developed by [Rituraj Shakti](https://www.freelancer.com/u/riturajshakti). You can contact me at <riturajshakti@gmail.com>
