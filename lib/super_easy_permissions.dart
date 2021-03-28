
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission/permission.dart';

enum Permissions {
  // iOS
  Internet,
  // both
  Calendar,
  // both
  Camera,
  // both
  Contacts,
  // both
  Microphone,
  // both
  Location,
  // iOS
  WhenInUse,
  // Android
  Phone,
  // Android
  Sensors,
  // Android
  SMS,
  // Android
  Storage,
  // Android
  State,
}

class SuperEasyPermissions {
  static const MethodChannel _channel =
      const MethodChannel('super_easy_permissions');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Asks(request) for permission and return true if granted, otherwise returns false
  /// If the permission is permanently denied, This will open the settings
  static Future<bool> askPermission(Permissions permission) async {
    int result = await getPermissionResult(permission);
    var permissionName = _getEquivalentPermissionName(permission);
    if (result == 0) {
      // Code for deny (false)
      await Permission.requestPermissions([permissionName]);
      result = await getPermissionResult(permission);
      return result == 1;
    } else if (result == -1) {
      // Code for notAgain (false)
      await Permission.requestPermissions([permissionName]);
      result = await getPermissionResult(permission);
      if (result == 1) return true;
      await Permission.openSettings();
      result = await getPermissionResult(permission);
      return result == 1;
    } else {
      return true;
    }
  }

  /// returns true if permission is granted, otherwise return false
  static Future<bool> isGranted(Permissions permission) async {
    return (await getPermissionResult(permission)) == 1;
  }

  /// returns true if permission is temporary or permanently denied, otherwise returns false
  /// You can also use:
  ///     if(!SuperEasyPermissions.isGranted(Permissions.XXXXXXX) {
  ///       ...
  ///     }
  static Future<bool> isDenied(Permissions permission) async {
    return (await getPermissionResult(permission)) != 1;
  }

  /// returns true if permission is granted, otherwise return false
  static Future<bool> isPermanentlyDenied(Permissions permission) async {
    return (await getPermissionResult(permission)) == -1;
  }

  /// Return 1 if permission is granted
  /// return 0 if denied
  /// return -1 if user set to don't ask again
  static Future<int> getPermissionResult(Permissions permission) async {
    var permissionName = _getEquivalentPermissionName(permission);
    var permissionStatus =
        (await Permission.getPermissionsStatus([permissionName]))[0].permissionStatus;
    int result;
    if (permissionStatus == PermissionStatus.allow) {
      result = 1;
    } else if (permissionStatus == PermissionStatus.always) {
      result = 1;
    } else if (permissionStatus == PermissionStatus.whenInUse) {
      result = 1;
    } else if (permissionStatus == PermissionStatus.deny) {
      result = 0;
    } else if (permissionStatus == PermissionStatus.notAgain) {
      result = -1;
    } else {
      result = 0;
    }
    return result;
  }

  static PermissionName _getEquivalentPermissionName(Permissions permissionName) {
    var map = <Permissions, PermissionName>{
      Permissions.Internet: PermissionName.Internet,
      Permissions.Calendar: PermissionName.Calendar,
      Permissions.Camera: PermissionName.Camera,
      Permissions.Contacts: PermissionName.Contacts,
      Permissions.Microphone: PermissionName.Microphone,
      Permissions.Location: PermissionName.Location,
      Permissions.WhenInUse: PermissionName.WhenInUse,
      Permissions.Phone: PermissionName.Phone,
      Permissions.Sensors: PermissionName.Sensors,
      Permissions.SMS: PermissionName.SMS,
      Permissions.Storage: PermissionName.Storage,
      Permissions.State: PermissionName.State,
    };
    return map[permissionName];
  }
}
