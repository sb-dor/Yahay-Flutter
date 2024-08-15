import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_state.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_app_folder_screen/telegram_browse_app_folder_screen.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_app_folder_screen/telegram_browse_folder_data_screen.dart';

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
      child: StreamBuilder(
        stream: _telegramFilePickerBloc.states,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const SizedBox();
            case ConnectionState.active:
            case ConnectionState.done:
              final state = snapshot.requireData;
              return ListView(
                controller: widget.parentScrollController,
                children: [
                  Visibility(
                    visible: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 0,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AnimatedSlide(
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 300),
                      offset: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 0
                          ? Offset.zero
                          : const Offset(1, 0),
                      child: AnimatedOpacity(
                        opacity:
                            state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 0
                                ? 1
                                : 0,
                        duration: const Duration(seconds: 1),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const TelegramFilesFromStoragesWidget(),
                            const SizedBox(height: 15),
                            TelegramResentFilesFromStorageWidget(
                              telegramFilePickerBloc: widget.telegramFilePickerBloc,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    visible: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 1,
                    child: PopScope(
                      canPop: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 1
                          ? false
                          : true,
                      onPopInvokedWithResult: (v, r) {
                        _telegramFilePickerBloc.events
                            .add(const SelectScreenForFilesPickerScreenEvent(0));
                      },
                      child: AnimatedSlide(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 300),
                        offset:
                            state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 1
                                ? Offset.zero
                                : const Offset(1, 0),
                        child: AnimatedOpacity(
                            opacity:
                                state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                                        1
                                    ? 1
                                    : 0,
                            duration: const Duration(seconds: 1),
                            child: const TelegramBrowseAppFolderScreen()),
                      ),
                    ),
                  ),
                  Visibility(
                    child: PopScope(
                      canPop: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 2
                          ? false
                          : true,
                      onPopInvokedWithResult: (v, r) {
                        _telegramFilePickerBloc.events
                            .add(const SelectScreenForFilesPickerScreenEvent(0));
                      },
                      child: AnimatedSlide(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 300),
                        offset:
                            state.telegramFilePickerStateModel.filePickerScreenSelectedScreen == 2
                                ? Offset.zero
                                : const Offset(1, 0),
                        child: AnimatedOpacity(
                            opacity:
                                state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                                        2
                                    ? 1
                                    : 0,
                            duration: const Duration(seconds: 1),
                            child: const TelegramBrowseFolderDataScreen()),
                      ),
                    ),
                  ),
                ], //TelegramBrowseFolderDataScreen
              );
          }
        },
      ),
    );
  }
}
