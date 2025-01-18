import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/mixins/folder_creator/folder_creator.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/pages/screens/telegram_app_folder_screen/telegram_browse_app_folder_screen.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/pages/screens/telegram_app_folder_screen/telegram_browse_folder_data_screen.dart';
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

class _TelegramFilesPickerScreenState extends State<TelegramFilesPickerScreen> with FolderCreator {
  late final TelegramFilePickerBloc _telegramFilePickerBloc;
  late final TelegramFilePickerStateModel _telegramFilePickerStateModel;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerBloc = widget.telegramFilePickerBloc;
    _telegramFilePickerStateModel = _telegramFilePickerBloc.state.telegramFilePickerStateModel;
    // final currentStateModel = _telegramFilePickerBloc.state.telegramFilePickerStateModel;
    widget.parentScrollController.addListener(() {
      if (widget.parentScrollController.offset ==
              widget.parentScrollController.position.maxScrollExtent &&
          _telegramFilePickerBloc.state is FilesPickerState) {
        if (_telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                TelegramFileFolderEnum.browseTheGalleryFolder ||
            _telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                TelegramFileFolderEnum.browseTheFolder) {
          _telegramFilePickerBloc
              .add(const TelegramFilePickerEvents.paginateSpecificFolderDataEvent());
        } else {
          // pagination here
          _telegramFilePickerBloc.add(const TelegramFilePickerEvents.recentFilesPaginationEvent());

          // if (currentStateModel.recentFilesPagination.length ==
          //     currentStateModel.recentFiles.length) {
          //   _telegramFilePickerBloc.events.add(
          //     const OpenHideBottomTelegramButtonEvent(
          //       false,
          //     ),
          //   );
          // }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        debugPrint("listening data: ${notification.direction}");
        if (notification.direction == ScrollDirection.forward) {
          _telegramFilePickerBloc.add(
            const TelegramFilePickerEvents.openHideBottomTelegramButtonEvent(
              true,
            ),
          );
        } else if (notification.direction == ScrollDirection.reverse) {
          _telegramFilePickerBloc.add(
            const TelegramFilePickerEvents.openHideBottomTelegramButtonEvent(
              false,
            ),
          );
        }
        return true;
      },
      child: BlocBuilder<TelegramFilePickerBloc, TelegramFilePickerStates>(
        builder: (context, state) {
          return ListView(
            controller: widget.parentScrollController,
            children: [
              Visibility(
                visible: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                    TelegramFileFolderEnum.recentDownloadsScreen,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedSlide(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 300),
                  offset: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                          TelegramFileFolderEnum.recentDownloadsScreen
                      ? Offset.zero
                      : const Offset(1, 0),
                  child: AnimatedOpacity(
                    opacity: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                            TelegramFileFolderEnum.recentDownloadsScreen
                        ? 1
                        : 0,
                    duration: const Duration(seconds: 1),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        TelegramFilesFromStoragesWidget(
                          telegramFilePickerBloc: widget.telegramFilePickerBloc,
                        ),
                        const SizedBox(height: 15),
                        TelegramResentFilesFromStorageWidget(
                          telegramFilePickerBloc: widget.telegramFilePickerBloc,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // apps folder
              Visibility(
                maintainAnimation: true,
                maintainState: true,
                visible: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                    TelegramFileFolderEnum.browseTheAppsFolder,
                child: PopScope(
                  canPop: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                          TelegramFileFolderEnum.browseTheAppsFolder
                      ? false
                      : true,
                  onPopInvokedWithResult: (v, r) {
                    _telegramFilePickerBloc.add(
                      const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
                        TelegramFileFolderEnum.recentDownloadsScreen,
                      ),
                    );
                  },
                  child: AnimatedSlide(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 300),
                    offset: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                            TelegramFileFolderEnum.browseTheAppsFolder
                        ? Offset.zero
                        : const Offset(1, 0),
                    child: AnimatedOpacity(
                      opacity: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                              TelegramFileFolderEnum.browseTheAppsFolder
                          ? 1
                          : 0,
                      duration: const Duration(seconds: 1),
                      child: TelegramBrowseAppFolderScreen(
                        telegramFilePickerBloc: _telegramFilePickerBloc,
                      ),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                    TelegramFileFolderEnum.browseTheFolder,
                maintainAnimation: true,
                maintainState: true,
                child: PopScope(
                  canPop: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                          TelegramFileFolderEnum.browseTheFolder
                      ? false
                      : true,
                  onPopInvokedWithResult: (v, r) {
                    _telegramFilePickerBloc.add(
                      const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
                        TelegramFileFolderEnum.browseTheAppsFolder,
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 300), () {
                      _telegramFilePickerBloc
                          .add(const TelegramFilePickerEvents.clearSelectedGalleryFileEvent());
                    });
                  },
                  child: AnimatedSlide(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 300),
                    offset: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                            TelegramFileFolderEnum.browseTheFolder
                        ? Offset.zero
                        : const Offset(1, 0),
                    child: AnimatedOpacity(
                      opacity: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                              TelegramFileFolderEnum.browseTheFolder
                          ? 1
                          : 0,
                      duration: const Duration(seconds: 1),
                      child: TelegramBrowseFolderDataScreen(
                        onBackFolder: () async {
                          _telegramFilePickerBloc.add(
                            const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
                              TelegramFileFolderEnum.browseTheAppsFolder,
                            ),
                          );
                          Future.delayed(const Duration(milliseconds: 300), () {
                            _telegramFilePickerBloc.add(
                                const TelegramFilePickerEvents.clearSelectedGalleryFileEvent());
                          });
                        },
                        telegramFilePickerBloc: _telegramFilePickerBloc,
                      ),
                    ),
                  ),
                ),
              ),

              // gallery folder data
              Visibility(
                visible: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                    TelegramFileFolderEnum.browseTheGalleryFolder,
                maintainAnimation: true,
                maintainState: true,
                child: PopScope(
                  canPop: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                          TelegramFileFolderEnum.browseTheGalleryFolder
                      ? false
                      : true,
                  onPopInvokedWithResult: (v, r) {
                    _telegramFilePickerBloc.add(
                      const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
                        TelegramFileFolderEnum.recentDownloadsScreen,
                      ),
                    );

                    Future.delayed(const Duration(milliseconds: 300), () {
                      _telegramFilePickerBloc
                          .add(const TelegramFilePickerEvents.clearSelectedGalleryFileEvent());
                    });
                  },
                  child: AnimatedSlide(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 300),
                    offset: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                            TelegramFileFolderEnum.browseTheGalleryFolder
                        ? Offset.zero
                        : const Offset(1, 0),
                    child: AnimatedOpacity(
                      opacity: state.telegramFilePickerStateModel.filePickerScreenSelectedScreen ==
                              TelegramFileFolderEnum.browseTheGalleryFolder
                          ? 1
                          : 0,
                      duration: const Duration(seconds: 1),
                      child: TelegramBrowseFolderDataScreen(
                        onBackFolder: () async {
                          _telegramFilePickerBloc.add(
                            const TelegramFilePickerEvents.selectScreenForFilesPickerScreenEvent(
                              TelegramFileFolderEnum.recentDownloadsScreen,
                            ),
                          );

                          Future.delayed(const Duration(milliseconds: 300), () {
                            _telegramFilePickerBloc
                                .add(const TelegramFilePickerEvents.clearSelectedGalleryFileEvent());
                          });
                        },
                        telegramFilePickerBloc: _telegramFilePickerBloc,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
