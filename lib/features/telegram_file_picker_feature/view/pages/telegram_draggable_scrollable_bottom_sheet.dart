import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/bottom_picker_button/telegram_bottom_picker_button.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_gallery_file_picker_screen.dart';
import 'package:yahay/injections/injections.dart';

class TelegramDraggableScrollableBottomSheet extends StatefulWidget {
  const TelegramDraggableScrollableBottomSheet({super.key});

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
    _telegramFilePickerBloc = snoopy<TelegramFilePickerBloc>();
    _telegramFilePickerBloc.events.add(InitAllPicturesEvent());
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    _telegramFilePickerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _draggableScrollableController,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      expand: false,
      builder: (context, scrollController) {
        return Stack(
          children: [
            TelegramGalleryFilePickerScreen(
              telegramFilePickerBloc: _telegramFilePickerBloc,
              parentScrollController: scrollController,
            ),
            const AnimatedPositioned(
              duration: Duration(milliseconds: 350),
              bottom: 0,
              right: 0,
              left: 0,
              child: TelegramBottomPickerButton(),
            ),
          ],
        );
      },
    );
  }
}
