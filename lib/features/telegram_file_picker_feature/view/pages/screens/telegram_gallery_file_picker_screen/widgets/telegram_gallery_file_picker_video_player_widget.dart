import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/injections/injections.dart';

class TelegramGalleryFilePickerVideoPlayerWidget extends StatefulWidget {
  final TelegramFileImageEntity item;
  final TelegramFilePickerBloc telegramFilePickerBloc;

  const TelegramGalleryFilePickerVideoPlayerWidget({
    super.key,
    required this.item,
    required this.telegramFilePickerBloc,
  });

  @override
  State<TelegramGalleryFilePickerVideoPlayerWidget> createState() =>
      _TelegramGalleryFilePickerVideoPlayerWidgetState();
}

class _TelegramGalleryFilePickerVideoPlayerWidgetState
    extends State<TelegramGalleryFilePickerVideoPlayerWidget> {
  late final TelegramFilePickerStateModel _currentStateModel;

  @override
  void initState() {
    super.initState();
    _currentStateModel = widget.telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding: _currentStateModel.isFileInsidePickedFiles(widget.item)
          ? const EdgeInsets.all(10)
          : EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.memory(
                widget.item.videoPreview!,
                fit: BoxFit.cover,
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
            Positioned(
              bottom: 5,
              left: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                    0.4,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.play_arrow,
                      size: 15,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      snoopy<ReusableGlobalFunctions>().getNormalDuration(
                        widget.item.videoPlayerController?.value.duration,
                      ),
                      style: GoogleFonts.aBeeZee(fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
