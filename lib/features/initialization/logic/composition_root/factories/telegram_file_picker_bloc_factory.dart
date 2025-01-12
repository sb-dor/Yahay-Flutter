import 'package:yahay/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/repo/telegram_file_picker_repo_impl.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';

final class TelegramFilePickerBlocFactory extends Factory<TelegramFilePickerBloc> {
  final CameraHelperService _cameraHelperService;

  TelegramFilePickerBlocFactory({
    required CameraHelperService cameraHelperService,
  }) : _cameraHelperService = cameraHelperService;

  @override
  TelegramFilePickerBloc create() {
    //
    final TelegramFilePickerRepo telegramFilePickerRepo = TelegramFilePickerRepoImpl();
    //
    return TelegramFilePickerBloc(
      telegramFilePickerRepo,
      _cameraHelperService,
    );
  }
}
