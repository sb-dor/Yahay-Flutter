import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/injections/injections.dart';

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
          widget.parentScrollController.position.maxScrollExtent) {
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
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CameraPreview(
                              item.cameraController!,
                            ),
                          ),
                        ),
                        const Positioned.fill(
                          child: Center(
                            child: Icon(
                              CupertinoIcons.camera_fill,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (item.videoPlayerController != null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: SizedBox.expand(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: item.videoPlayerController!.value.size.width,
                                  height: item.videoPlayerController!.value.size.height,
                                  child: VideoPlayer(
                                    item.videoPlayerController!,
                                  ),
                                ),
                              ),
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
                                      item.videoPlayerController?.value.duration,
                                    ),
                                    style: GoogleFonts.aBeeZee(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (item.file != null) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              item.file!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () =>
                                _telegramFilePickerBloc.events.add(SelectGalleryFileEvent(item)),
                            icon: currentStateModel.isFileInsidePickedFiles(item)
                                ? const Icon(Icons.circle)
                                : const Icon(Icons.circle_outlined),
                            color: currentStateModel.isFileInsidePickedFiles(item)
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                      ],
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
