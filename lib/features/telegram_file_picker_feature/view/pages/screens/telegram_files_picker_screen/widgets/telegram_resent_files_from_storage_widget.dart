import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/reusable_widgets/telegram_storage_file_widget.dart';
import 'package:yahay/injections/injections.dart';

class TelegramResentFilesFromStorageWidget extends StatefulWidget {
  final TelegramFilePickerBloc telegramFilePickerBloc;

  const TelegramResentFilesFromStorageWidget({
    super.key,
    required this.telegramFilePickerBloc,
  });

  @override
  State<TelegramResentFilesFromStorageWidget> createState() =>
      _TelegramResentFilesFromStorageWidgetState();
}

class _TelegramResentFilesFromStorageWidgetState
    extends State<TelegramResentFilesFromStorageWidget> {
  late final TelegramFilePickerStateModel _telegramFilePickerStateModel;
  late final ReusableGlobalFunctions _reusableFunctions;
  late final AppThemeBloc _appThemeBloc;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerStateModel =
        widget.telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
    _reusableFunctions = snoopy<ReusableGlobalFunctions>();
    _appThemeBloc = snoopy<AppThemeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: _appThemeBloc.theme.value.brightness == Brightness.dark
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
          TelegramStorageFileWidget(
            list: _telegramFilePickerStateModel.recentFilesPagination,
          )
        ],
      ),
    );
  }
}
