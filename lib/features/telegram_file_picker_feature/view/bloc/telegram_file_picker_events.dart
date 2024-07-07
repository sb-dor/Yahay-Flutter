import 'package:flutter/foundation.dart';

@immutable
abstract class TelegramFilePickerEvents {}

class InitAllPicturesEvent extends TelegramFilePickerEvents {}

class ClosePopupEvent extends TelegramFilePickerEvents {}
