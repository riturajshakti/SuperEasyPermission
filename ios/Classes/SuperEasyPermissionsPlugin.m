#import "SuperEasyPermissionsPlugin.h"
#if __has_include(<super_easy_permissions/super_easy_permissions-Swift.h>)
#import <super_easy_permissions/super_easy_permissions-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "super_easy_permissions-Swift.h"
#endif

@implementation SuperEasyPermissionsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSuperEasyPermissionsPlugin registerWithRegistrar:registrar];
}
@end
