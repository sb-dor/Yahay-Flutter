import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class TelegramFilePickerInj {
  static Future<void> telegramFilePickerInj() async {
    //
    snoopy.registerLazySingleton<TelegramFilePickerBloc>(
      () => TelegramFilePickerBloc(),
    );
  }
}
