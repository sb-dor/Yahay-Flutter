import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/pages/screens/telegram_gallery_file_picker_screen.dart';

class TelegramDraggableScrollableBottomSheet extends StatefulWidget {
  const TelegramDraggableScrollableBottomSheet({super.key});

  @override
  State<TelegramDraggableScrollableBottomSheet> createState() =>
      _TelegramDraggableScrollableBottomSheetState();
}

class _TelegramDraggableScrollableBottomSheetState
    extends State<TelegramDraggableScrollableBottomSheet> {
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  @override
  void dispose() {
    _draggableScrollableController.dispose();
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
        return TelegramGalleryFilePickerScreen(
          parentScrollController: scrollController,
        );
      },
    );
  }
}
