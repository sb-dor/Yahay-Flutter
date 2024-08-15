import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_state.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_app_folder_screen/telegram_browse_app_folder_screen.dart';

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
  int selectedScreen = 0;
  final List<Widget> widgetsForChangeScreen = const [
    SizedBox(), // sizedBox is just a temp widget for indexing
    TelegramBrowseAppFolderScreen(),
    TelegramBrowseAppFolderScreen(),
  ];

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
          StreamBuilder(
            stream: _telegramFilePickerBloc.states,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const SizedBox();
                case ConnectionState.active:
                case ConnectionState.done:
                  final state = snapshot.requireData;
                  if (state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 0) {
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const TelegramFilesFromStoragesWidget(),
                        const SizedBox(height: 15),
                        TelegramResentFilesFromStorageWidget(
                          telegramFilePickerBloc: widget.telegramFilePickerBloc,
                        ),
                      ],
                    );
                  } else if (state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                      1) {
                    return const TelegramBrowseAppFolderScreen();
                  } else {
                    return const SizedBox();
                  }
              }
            },
          ),
        ],
      ),
    );
  }
}
