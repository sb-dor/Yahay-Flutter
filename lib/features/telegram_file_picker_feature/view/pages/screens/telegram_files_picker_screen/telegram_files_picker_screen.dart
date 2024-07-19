import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_state.dart';

import 'widgets/telegram_files_from_storages_widget.dart';
import 'widgets/telegram_resent_files_from_storage_widget.dart';

class TelegramFilesPickerScreen extends StatefulWidget {
  final TelegramFilePickerBloc telegramFilePickerBloc;
  final ScrollController parentScrollController;

  const TelegramFilesPickerScreen({
    super.key,
    required this.telegramFilePickerBloc,
    required this.parentScrollController,
  });

  @override
  State<TelegramFilesPickerScreen> createState() => _TelegramFilesPickerScreenState();
}

class _TelegramFilesPickerScreenState extends State<TelegramFilesPickerScreen> {
  late final TelegramFilePickerBloc _telegramFilePickerBloc;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerBloc = widget.telegramFilePickerBloc;
    final currentStateModel = _telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
    widget.parentScrollController.addListener(() {
      if (widget.parentScrollController.offset ==
              widget.parentScrollController.position.maxScrollExtent &&
          _telegramFilePickerBloc.states.value is FilesPickerState) {
        // pagination here
        _telegramFilePickerBloc.events.add(const RecentFilesPaginationEvent());

        // if (currentStateModel.recentFilesPagination.length ==
        //     currentStateModel.recentFiles.length) {
        //   _telegramFilePickerBloc.events.add(
        //     const OpenHideBottomTelegramButtonEvent(
        //       false,
        //     ),
        //   );
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        debugPrint("listening data: ${notification.direction}");
        if (notification.direction == ScrollDirection.forward) {
          _telegramFilePickerBloc.events.add(
            const OpenHideBottomTelegramButtonEvent(
              true,
            ),
          );
        } else if (notification.direction == ScrollDirection.reverse) {
          _telegramFilePickerBloc.events.add(
            const OpenHideBottomTelegramButtonEvent(
              false,
            ),
          );
        }
        return true;
      },
      child: ListView(
        controller: widget.parentScrollController,
        children: [
          const TelegramFilesFromStoragesWidget(),
          const SizedBox(height: 15),
          TelegramResentFilesFromStorageWidget(
            telegramFilePickerBloc: widget.telegramFilePickerBloc,
          ),
        ],
      ),
    );
  }
}
