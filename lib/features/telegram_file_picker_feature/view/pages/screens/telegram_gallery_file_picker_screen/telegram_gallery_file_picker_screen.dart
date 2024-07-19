import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_state.dart';

import 'widgets/telegram_gallery_file_picker_camera_widget.dart';
import 'widgets/telegram_gallery_file_picker_image_widget.dart';
import 'widgets/telegram_gallery_file_picker_video_player_widget.dart';

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
  late final TelegramFilePickerBloc _telegramFilePickerBloc;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerBloc = widget.telegramFilePickerBloc;
    final currentStateModel = _telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
    widget.parentScrollController.addListener(() {
      if (widget.parentScrollController.offset ==
              widget.parentScrollController.position.maxScrollExtent &&
          _telegramFilePickerBloc.states.value is GalleryFilePickerState) {
        // pagination here
        _telegramFilePickerBloc.events.add(const ImagesAndVideoPaginationEvent());

        // why i wrote ".length -1" -> because of galleryPathPagination's first item is entity with
        // cameraController
        if (currentStateModel.galleryPathPagination.length - 1 ==
            currentStateModel.galleryPathFiles.length) {
          _telegramFilePickerBloc.events.add(
            const OpenHideBottomTelegramButtonEvent(
              false,
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    debugPrint("disposing gallery screen");
    // _scrollController.dispose();
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
            return const Align(alignment: Alignment.topCenter, child: LinearProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            final currentStateModel = snap.requireData.telegramFilePickerStateModel;
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
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                padding: const EdgeInsets.all(10),
                controller: widget.parentScrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                ),
                itemCount: currentStateModel.galleryPathPagination.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = currentStateModel.galleryPathPagination[index];

                  if (item.cameraController != null &&
                      (item.cameraController?.value.isInitialized ?? false)) {
                    return TelegramGalleryFilePickerCameraWidget(
                      cameraController: item.cameraController!,
                    );
                  } else if (item.videoPlayerController != null && item.videoPreview != null) {
                    return TelegramGalleryFilePickerVideoPlayerWidget(
                      item: item,
                      telegramFilePickerBloc: _telegramFilePickerBloc,
                    );
                  } else if (item.file != null) {
                    return TelegramGalleryFilePickerImageWidget(
                      item: item,
                      telegramFilePickerBloc: _telegramFilePickerBloc,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
        }
      },
    );
  }
}
