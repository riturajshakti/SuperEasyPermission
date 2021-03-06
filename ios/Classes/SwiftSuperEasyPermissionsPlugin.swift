import Flutter
import UIKit

public class SwiftSuperEasyPermissionsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "super_easy_permissions", binaryMessenger: registrar.messenger())
    let instance = SwiftSuperEasyPermissionsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
