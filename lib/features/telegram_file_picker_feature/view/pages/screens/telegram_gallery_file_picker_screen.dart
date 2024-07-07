import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';

class TelegramGalleryFilePickerScreen extends StatefulWidget {
  final TelegramFilePickerBloc telegramFilePickerBloc;
  final ScrollController parentScrollController;

  const TelegramGalleryFilePickerScreen({
    super.key,
    required this.telegramFilePickerBloc,
    required this.parentScrollController,
  });

  @override
  State<TelegramGalleryFilePickerScreen> createState() => _TelegramGalleryFilePickerScreenState();
}

class _TelegramGalleryFilePickerScreenState extends State<TelegramGalleryFilePickerScreen> {
  late final TelegramFilePickerStateModel _telegramFilePickerStateModel;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerStateModel =
        widget.telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      controller: widget.parentScrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
      ),
      itemCount: _telegramFilePickerStateModel.galleryPathFiles.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _telegramFilePickerStateModel.galleryPathFiles[index];
        return Container(
          child: Image.file(
            item.file!,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
