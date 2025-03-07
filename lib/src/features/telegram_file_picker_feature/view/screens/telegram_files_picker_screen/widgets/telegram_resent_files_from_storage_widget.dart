import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/reusable_widgets/telegram_storage_file_widget.dart';

class TelegramResentFilesFromStorageWidget extends StatefulWidget {
  const TelegramResentFilesFromStorageWidget({super.key});

  @override
  State<TelegramResentFilesFromStorageWidget> createState() =>
      _TelegramResentFilesFromStorageWidgetState();
}

class _TelegramResentFilesFromStorageWidgetState
    extends State<TelegramResentFilesFromStorageWidget> {
  late final TelegramFilePickerStateModel _telegramFilePickerStateModel;
  late final AppThemeBloc _appThemeBloc;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerStateModel =
        context.read<TelegramFilePickerBloc>().state.telegramFilePickerStateModel;
    _appThemeBloc = DependenciesScope.of(context, listen: false).appThemeBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color:
            _appThemeBloc.theme.value.brightness == Brightness.dark
                ? Colors.blueGrey.shade900.withOpacity(0.5)
                : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent downloaded files",
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 15),
          //
          // here should be the list of only files not images or videos
          TelegramStorageFileWidget(list: _telegramFilePickerStateModel.recentFilesPagination),
        ],
      ),
    );
  }
}
