import 'package:yahay/src/core/utils/camera_helper_service/camera_helper_service.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/composition_root.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/data/repo/telegram_file_picker_repo_impl.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/repo/telegram_file_picker_repo.dart';

final class TelegramFilePickerBlocFactory extends Factory<TelegramFilePickerBloc> {
  final CameraHelperService _cameraHelperService;

  TelegramFilePickerBlocFactory({required CameraHelperService cameraHelperService})
    : _cameraHelperService = cameraHelperService;

  @override
  TelegramFilePickerBloc create() {
    //
    final TelegramFilePickerRepo telegramFilePickerRepo = TelegramFilePickerRepoImpl();
    //
    final initialState = TelegramFilePickerStates.initial(TelegramFilePickerStateModel.idle());

    return TelegramFilePickerBloc(
      telegramFilePickerRepo: telegramFilePickerRepo,
      cameraHelperService: _cameraHelperService,
      initialState: initialState,
    );
  }
}
