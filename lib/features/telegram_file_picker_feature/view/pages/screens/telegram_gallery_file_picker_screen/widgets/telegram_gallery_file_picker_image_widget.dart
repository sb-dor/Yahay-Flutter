import 'package:flutter/material.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';

class TelegramGalleryFilePickerImageWidget extends StatefulWidget {
  final TelegramFileImageEntity item;
  final TelegramFilePickerBloc telegramFilePickerBloc;

  const TelegramGalleryFilePickerImageWidget({
    super.key,
    required this.item,
    required this.telegramFilePickerBloc,
  });

  @override
  State<TelegramGalleryFilePickerImageWidget> createState() =>
      _TelegramGalleryFilePickerImageWidgetState();
}

class _TelegramGalleryFilePickerImageWidgetState
    extends State<TelegramGalleryFilePickerImageWidget> {
  late final TelegramFilePickerStateModel _currentStateModel;

  @override
  void initState() {
    super.initState();
    _currentStateModel = widget.telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: _currentStateModel.isFileInsidePickedFiles(widget.item)
                ? const EdgeInsets.all(10)
                : EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                widget.item.file!,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                // width: 85.0,
                // height: 85.0,
                // cacheWidth: 300,
                // cacheHeight: 300,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: () => widget.telegramFilePickerBloc.events.add(SelectGalleryFileEvent(
              widget.item,
            )),
            icon: _currentStateModel.isFileInsidePickedFiles(widget.item)
                ? const Icon(Icons.check_circle)
                : const Icon(Icons.circle_outlined),
            color: _currentStateModel.isFileInsidePickedFiles(widget.item)
                ? Colors.blue
                : Colors.white,
          ),
        ),
      ],
    );
  }
}
