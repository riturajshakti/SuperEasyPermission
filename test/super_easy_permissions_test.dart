import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

void main() {
  const MethodChannel channel = MethodChannel('super_easy_permissions');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SuperEasyPermissions.platformVersion, '42');
  });
}
