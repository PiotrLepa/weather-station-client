import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void mockPermissions(Map<Permission, PermissionStatus> mocks) {
  const MethodChannel('flutter.baseflow.com/permissions/methods')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    final permissionValue = methodCall.arguments as int;
    final permissionMockResult = mocks.entries
        .firstWhere((element) => element.key.value == permissionValue);
    return permissionMockResult.value.index;
  });
}
