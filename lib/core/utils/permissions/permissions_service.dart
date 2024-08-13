import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<void> settingsAppOpener() async {
    await openAppSettings();
  }

  Future<bool> manageExternalStoragePermission() async {
    var checkPermissionForManagingExternalStorage = await Permission.manageExternalStorage.status;

    debugPrint("check external: $checkPermissionForManagingExternalStorage");

    if (checkPermissionForManagingExternalStorage != PermissionStatus.granted) {
      await Permission.manageExternalStorage.request();
    }

    checkPermissionForManagingExternalStorage = await Permission.manageExternalStorage.status;

    return checkPermissionForManagingExternalStorage == PermissionStatus.granted;
  }

  Future<bool> storagePermission() async {
    final checkPermissionForStorage = await Permission.storage.status;

    if (checkPermissionForStorage != PermissionStatus.granted) {
      final permissionForStorage = await Permission.storage.request();

      debugPrint("permission for managing storage denied $permissionForStorage");
      return permissionForStorage != PermissionStatus.granted;
    }
    return false;
  }
}
