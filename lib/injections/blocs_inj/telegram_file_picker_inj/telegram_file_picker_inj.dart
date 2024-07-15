import 'package:yahay/features/telegram_file_picker_feature/data/repo/telegram_file_picker_repo_impl.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/injections/injections.dart';

abstract class TelegramFilePickerInj {
  static Future<void> telegramFilePickerInj() async {
    //
    snoopy.registerLazySingleton<TelegramFilePickerRepo>(
      () => TelegramFilePickerRepoImpl(),
    );
    //
    snoopy.registerLazySingleton<TelegramFilePickerBloc>(
      () => TelegramFilePickerBloc(
        snoopy<TelegramFilePickerRepo>(),
      ),
    );
  }
}
