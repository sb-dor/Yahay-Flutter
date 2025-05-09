import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:path/path.dart' as path;

class TelegramStorageFileWidget extends StatefulWidget {
  final List<TelegramFileImageEntity> list;

  const TelegramStorageFileWidget({super.key, required this.list});

  @override
  State<TelegramStorageFileWidget> createState() => _TelegramStorageFileWidgetState();
}

class _TelegramStorageFileWidgetState extends State<TelegramStorageFileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        final item = widget.list[index];
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            context.read<TelegramFilePickerBloc>().add(
              TelegramFilePickerEvents.selectGalleryFileEvent(item),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (item.videoPlayerController != null && item.videoPreview != null)
                        _VideoItem(item: item)
                      else if (ReusableGlobalFunctions.instance.isImageFile(item.file?.path ?? ''))
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.file(item.file!, fit: BoxFit.cover, gaplessPlayback: true),
                          ),
                        )
                      else if (item.file != null)
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text(path.extension(item.file?.path ?? ''))),
                        )
                      else
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      BlocBuilder<TelegramFilePickerBloc, TelegramFilePickerStates>(
                        builder: (context, state) {
                          final telegramFilePickerStateModel = state.telegramFilePickerStateModel;
                          return Positioned(
                            bottom: -10,
                            right: 0,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 150),
                              opacity:
                                  telegramFilePickerStateModel.isFileInsidePickedFiles(item)
                                      ? 1
                                      : 0,
                              child: AnimatedScale(
                                scale:
                                    telegramFilePickerStateModel.isFileInsidePickedFiles(item)
                                        ? 1
                                        : 0,
                                duration: const Duration(milliseconds: 150),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.check, size: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  //
                  //
                  //
                  //
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.fileName ?? '-',
                          style: GoogleFonts.aBeeZee(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          TelegramFileImageModel.fromEntity(item)?.fileSize() ?? '',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _VideoItem extends StatelessWidget {
  final TelegramFileImageEntity item;

  const _VideoItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned.fill(child: Image.memory(fit: BoxFit.cover, item.videoPreview!)),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Icon(Icons.play_arrow)),
            ),
          ),
        ],
      ),
    );
  }
}
