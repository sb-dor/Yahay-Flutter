import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'bottom_picker_button/telegram_bottom_picker_button.dart';
import 'bottom_picker_button/telegram_bottom_sender_button.dart';
import 'screens/telegram_files_picker_screen/telegram_files_picker_screen.dart';
import 'screens/telegram_gallery_file_picker_screen/telegram_gallery_file_picker_screen.dart';

class TelegramDraggableScrollableBottomSheet extends StatelessWidget {
  final TelegramFilePickerBloc telegramFilePickerBloc;

  const TelegramDraggableScrollableBottomSheet({
    super.key,
    required this.telegramFilePickerBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: telegramFilePickerBloc,
      child: const _TelegramDraggableScrollableBottomSheetUI(),
    );
  }
}

class _TelegramDraggableScrollableBottomSheetUI extends StatefulWidget {
  const _TelegramDraggableScrollableBottomSheetUI();

  @override
  State<_TelegramDraggableScrollableBottomSheetUI> createState() =>
      _TelegramDraggableScrollableBottomSheetUIState();
}

class _TelegramDraggableScrollableBottomSheetUIState
    extends State<_TelegramDraggableScrollableBottomSheetUI> {
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    final telegramFilePickerBloc = context.read<TelegramFilePickerBloc>();
    telegramFilePickerBloc.add(
      const TelegramFilePickerEvents.initAllPicturesEvent(true),
    );
    Future.delayed(const Duration(milliseconds: 350), () {
      telegramFilePickerBloc.add(
        const TelegramFilePickerEvents.openHideBottomTelegramButtonEvent(true),
      );
    });
    // _telegramFilePickerBloc.events.add(const InitAllFilesEvent(initFilePickerState: false));
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TelegramFilePickerBloc, TelegramFilePickerStates>(
      builder: (context, state) {
        final currentStateModel = state.telegramFilePickerStateModel;
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
                  switch (state) {
                    Picker$InitialState() => const SizedBox(),
                    Picker$GalleryFileState() =>
                      TelegramGalleryFilePickerScreen(
                        parentScrollController: scrollController,
                      ),
                    Picker$FilesState() => TelegramFilesPickerScreen(
                      parentScrollController: scrollController,
                    ),
                    Picker$AudioFilesState() => const SizedBox(),
                  },
                  AnimatedPositioned(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 1000),
                    bottom: currentStateModel.pickedFiles.isNotEmpty ? 0 : -200,
                    right: 0,
                    left: 0,
                    child: const TelegramBottomSenderButton(),
                  ),
                  AnimatedPositioned(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 1000),
                    bottom:
                        (currentStateModel.openBottomSectionButton &&
                                currentStateModel.pickedFiles.isEmpty)
                            ? 0
                            : -200,
                    right: 0,
                    left: 0,
                    child: TelegramBottomPickerButton(
                      draggableScrollableController:
                          _draggableScrollableController,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
