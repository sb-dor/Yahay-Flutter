import 'dart:io';

class FolderCreator {
  static FolderCreator? _instance;

  static FolderCreator get instance => _instance ??= FolderCreator._();

  FolderCreator._();

  //
  Future<void> creatorFolder({required String path}) async {
    final directory = Directory(path);
    if (directory.existsSync()) return;
    directory.createSync();
  }

  // ----------------------------------------------
}
