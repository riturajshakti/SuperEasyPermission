import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// Permission constants for android and ios
enum Permissions {
  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  accessMediaLocation,

  /// When running on Android Q and above: Activity Recognition When running
  /// on Android < Q: Nothing iOS: Nothing
  activityRecognition,

  /// iOS 13 and above: The authorization state of Core Bluetooth manager.
  /// When running < iOS 13 or Android this is always allowed.
  bluetooth,

  /// Android: Calendar iOS: Calendar (Events)
  calendar,

  /// Android: Camera iOS: Photos (Camera Roll and Camera)
  camera,

  /// Android: Contacts iOS: AddressBook
  contacts,

  /// Android: Ignore Battery Optimizations
  ignoreBatteryOptimizations,

  /// Android: Fine and Coarse Location iOS: CoreLocation (Always and WhenInUse)
  location,

  /// Android: When running on Android < Q: Fine and Coarse Location
  /// When running on Android Q and above: Background Location Permission iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location iOS: CoreLocation - WhenInUse
  locationWhenInUse,

  /// Android: None iOS: MPMediaLibrary
  mediaLibrary,

  /// Android: Microphone iOS: Microphone
  microphone,

  /// Android: Notification iOS: Notification
  notification,

  /// Android: Phone iOS: Nothing
  phone,

  /// Android: Nothing iOS: Photos iOS 14+ read & write access level
  photos,

  /// Android: Nothing iOS: Photos iOS 14+ read & write access level
  photosAddOnly,

  /// Android: Nothing iOS: Reminders
  reminders,

  /// Android: Body Sensors iOS: CoreMotion
  sensors,

  /// Android: Sms iOS: Nothing
  sms,

  /// Android: Microphone iOS: Speech
  speech,

  /// Android: External Storage iOS: Access to folders like Documents
  ///  or Downloads. Implicitly granted.
  storage,
}

class SuperEasyPermissions {
  static const MethodChannel _channel =
      const MethodChannel('super_easy_permissions');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Asks(request) for permission and return true if granted, otherwise returns false.
  /// If the permission is permanently denied, This will open the settings
  static Future<bool> askPermission(Permissions permission) async {
    int result = await getPermissionResult(permission);
    var permissionName = _getEquivalentPermissionName(permission);
    if (result == 0) {
      // Code for deny (false)
      var status = await permissionName.request();
      return status == PermissionStatus.granted ||
          status == PermissionStatus.limited;
    } else if (result == -1) {
      // Code for notAgain (false)
      await openAppSettings();
      result = await getPermissionResult(permission);
      return result == 1;
    } else {
      // already granted
      return true;
    }
  }

  /// returns true if permission is granted, otherwise return false
  static Future<bool> isGranted(Permissions permission) async {
    return (await getPermissionResult(permission)) == 1;
  }

  /// returns true if permission is temporary or permanently denied, otherwise returns false.
  static Future<bool> isDenied(Permissions permission) async {
    return (await getPermissionResult(permission)) != 1;
  }

  /// returns true if permission is permanently denied, otherwise return false
  static Future<bool> isPermanentlyDenied(Permissions permission) async {
    return (await getPermissionResult(permission)) == -1;
  }

  /// Return 1 if permission is granted,
  /// return 0 if denied,
  /// return -1 if user set to don't ask again
  static Future<int> getPermissionResult(Permissions permission) async {
    var permissionName = _getEquivalentPermissionName(permission);
    var permissionStatus = await permissionName.status;
    int result;
    if (permissionStatus == PermissionStatus.granted) {
      result = 1;
    } else if (permissionStatus == PermissionStatus.limited) {
      result = 1;
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      result = -1;
    } else {
      result = 0;
    }
    return result;
  }

  static Permission _getEquivalentPermissionName(Permissions permissionName) {
    var map = <Permissions, Permission>{
      Permissions.accessMediaLocation: Permission.accessMediaLocation,
      Permissions.activityRecognition: Permission.activityRecognition,
      Permissions.bluetooth: Permission.bluetooth,
      Permissions.calendar: Permission.calendar,
      Permissions.camera: Permission.camera,
      Permissions.contacts: Permission.contacts,
      Permissions.ignoreBatteryOptimizations:
          Permission.ignoreBatteryOptimizations,
      Permissions.location: Permission.location,
      Permissions.locationAlways: Permission.locationAlways,
      Permissions.locationWhenInUse: Permission.locationWhenInUse,
      Permissions.mediaLibrary: Permission.mediaLibrary,
      Permissions.microphone: Permission.microphone,
      Permissions.notification: Permission.notification,
      Permissions.phone: Permission.phone,
      Permissions.photos: Permission.photos,
      Permissions.photosAddOnly: Permission.photosAddOnly,
      Permissions.reminders: Permission.reminders,
      Permissions.sensors: Permission.sensors,
      Permissions.sms: Permission.sms,
      Permissions.speech: Permission.speech,
      Permissions.storage: Permission.storage,
    };
    return map[permissionName];
  }
}
