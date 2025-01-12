import 'package:flutter/material.dart';
import 'package:yahay/features/initialization/logic/composition_root/factories/telegram_file_picker_bloc_factory.dart';
import 'package:yahay/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_state.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/bottom_picker_button/telegram_bottom_picker_button.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_files_picker_screen/telegram_files_picker_screen.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_gallery_file_picker_screen/telegram_gallery_file_picker_screen.dart';
import 'bottom_picker_button/telegram_bottom_sender_button.dart';

class TelegramDraggableScrollableBottomSheet extends StatefulWidget {
  final ValueChanged<List<TelegramFileImageEntity?>> selectedItems;

  const TelegramDraggableScrollableBottomSheet({
    super.key,
    required this.selectedItems,
  });

  @override
  State<TelegramDraggableScrollableBottomSheet> createState() =>
      _TelegramDraggableScrollableBottomSheetState();
}

class _TelegramDraggableScrollableBottomSheetState
    extends State<TelegramDraggableScrollableBottomSheet> {
  late final TelegramFilePickerBloc _telegramFilePickerBloc;
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _telegramFilePickerBloc = TelegramFilePickerBlocFactory(
      cameraHelperService: DependenciesScope.of(context, listen: false).cameraHelperService,
    ).create();
    _telegramFilePickerBloc.events.add(InitAllPicturesEvent(
      true,
      controller: _draggableScrollableController,
    ));
    Future.delayed(
      const Duration(milliseconds: 350),
      () {
        _telegramFilePickerBloc.events.add(
          const OpenHideBottomTelegramButtonEvent(
            true,
          ),
        );
      },
    );
    // _telegramFilePickerBloc.events.add(const InitAllFilesEvent(initFilePickerState: false));
  }

  @override
  void dispose() {
    widget.selectedItems(
      _telegramFilePickerBloc.states.value.telegramFilePickerStateModel.clonedPickedFiles,
    );
    _draggableScrollableController.dispose();
    _telegramFilePickerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _telegramFilePickerBloc.states,
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const SizedBox();
          case ConnectionState.active:
          case ConnectionState.done:
            final currentStateModel = snap.requireData.telegramFilePickerStateModel;
            return DraggableScrollableSheet(
              controller: _draggableScrollableController,
              initialChildSize: 0.5,
              maxChildSize: 0.96,
              minChildSize: 0.3,
              expand: false,
              builder: (context, scrollController) {
                return SafeArea(
                  child: Stack(
                    children: [
                      if (snap.requireData is GalleryFilePickerState)
                        TelegramGalleryFilePickerScreen(
                          telegramFilePickerBloc: _telegramFilePickerBloc,
                          parentScrollController: scrollController,
                        )
                      else if (snap.requireData is FilesPickerState)
                        TelegramFilesPickerScreen(
                          telegramFilePickerBloc: _telegramFilePickerBloc,
                          parentScrollController: scrollController,
                        ),
                      AnimatedPositioned(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 1000),
                        bottom: currentStateModel.clonedPickedFiles.isNotEmpty ? 0 : -200,
                        right: 0,
                        left: 0,
                        child: const TelegramBottomSenderButton(),
                      ),
                      AnimatedPositioned(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 1000),
                        bottom: (currentStateModel.openBottomSectionButton &&
                                currentStateModel.clonedPickedFiles.isEmpty)
                            ? 0
                            : -200,
                        right: 0,
                        left: 0,
                        child: TelegramBottomPickerButton(
                          telegramFilePickerBloc: _telegramFilePickerBloc,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
