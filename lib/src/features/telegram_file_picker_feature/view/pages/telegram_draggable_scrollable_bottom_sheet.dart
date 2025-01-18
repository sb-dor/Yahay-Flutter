import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/features/initialization/logic/composition_root/factories/telegram_file_picker_bloc_factory.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/pages/bottom_picker_button/telegram_bottom_picker_button.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/pages/screens/telegram_files_picker_screen/telegram_files_picker_screen.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/pages/screens/telegram_gallery_file_picker_screen/telegram_gallery_file_picker_screen.dart';
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
    _telegramFilePickerBloc.add(TelegramFilePickerEvents.initAllPicturesEvent(
      true,
      controller: _draggableScrollableController,
    ));
    Future.delayed(
      const Duration(milliseconds: 350),
      () {
        _telegramFilePickerBloc.add(
          const TelegramFilePickerEvents.openHideBottomTelegramButtonEvent(
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
      _telegramFilePickerBloc.state.telegramFilePickerStateModel.clonedPickedFiles,
    );
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
                    // TODO: Handle this case.
                    InitialPickerState() => const SizedBox(),
                    // TODO: Handle this case.
                    GalleryFilePickerState() => const SizedBox(),
                    // TODO: Handle this case.
                    FilesPickerState() => TelegramFilesPickerScreen(
                        telegramFilePickerBloc: _telegramFilePickerBloc,
                        parentScrollController: scrollController,
                      ),
                    // TODO: Handle this case.
                    MusicFilesPickerState() => TelegramGalleryFilePickerScreen(
                        telegramFilePickerBloc: _telegramFilePickerBloc,
                        parentScrollController: scrollController,
                      ),
                  },
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
      },
    );
  }
}
