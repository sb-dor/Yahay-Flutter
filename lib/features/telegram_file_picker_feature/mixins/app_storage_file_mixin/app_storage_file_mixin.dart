import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_with_compressed_and_original_path_entity.dart';

mixin class AppStorageFileMixin {
  //
  Stream<TelegramFileImageWithCompressedAndOriginalPathEntity?> getSpecificFolderDataStream(
    String path,
  ) async* {
    //

    final ReceivePort mainPort = ReceivePort();

    final rootIsolateToken = RootIsolateToken.instance!;

    Isolate.spawn(_isolateHelper, [
      rootIsolateToken,
      mainPort.sendPort,
      path,
    ]);

    await for (final each in mainPort) {}
  }

  //
  static Future<void> _isolateHelper(List<dynamic> args) async {
    RootIsolateToken mainRootIsolateToken = args[0] as RootIsolateToken;
    SendPort sendPort = args[1] as SendPort;
    String path = args[2] as String;

    final directory = Directory(path);

    if (!directory.existsSync()) return;
  }
//
}
