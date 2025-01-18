import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
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
    final currentStateModel = _telegramFilePickerBloc.state.telegramFilePickerStateModel;
    widget.parentScrollController.addListener(() {
      if (widget.parentScrollController.offset ==
              widget.parentScrollController.position.maxScrollExtent &&
          _telegramFilePickerBloc.state is GalleryFilePickerState) {
        // pagination here
        _telegramFilePickerBloc.add(const TelegramFilePickerEvents.imagesAndVideoPaginationEvent());

        // why i wrote ".length -1" -> because of galleryPathPagination's first item is entity with
        // cameraController
        if (currentStateModel.galleryPathPagination.length - 1 ==
            currentStateModel.galleryPathFiles.length) {
          _telegramFilePickerBloc.add(
            const TelegramFilePickerEvents.openHideBottomTelegramButtonEvent(
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
    return BlocBuilder<TelegramFilePickerBloc, TelegramFilePickerStates>(
      builder: (context, snap) {
        final currentStateModel = snap.telegramFilePickerStateModel;
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
      },
    );
  }
}
