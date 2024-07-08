import 'dart:io';

import 'package:flutter/foundation.dart';

@immutable
abstract class TelegramFilePickerEvents {}

class InitAllPicturesEvent extends TelegramFilePickerEvents {}

class ClosePopupEvent extends TelegramFilePickerEvents {}

class FileStreamHandlerEvent extends TelegramFilePickerEvents {
  final File? file;

  FileStreamHandlerEvent(this.file);
}
