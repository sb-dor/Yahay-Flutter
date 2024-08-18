import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/injections/injections.dart';
import 'package:path/path.dart' as path;

class TelegramStorageFileWidget extends StatefulWidget {
  final List<TelegramFileImageEntity> list;

  const TelegramStorageFileWidget({
    super.key,
    required this.list,
  });

  @override
  State<TelegramStorageFileWidget> createState() => _TelegramStorageFileWidgetState();
}

class _TelegramStorageFileWidgetState extends State<TelegramStorageFileWidget> {
  late TelegramFilePickerBloc _telegramFilePickerBloc;
  late TelegramFilePickerStateModel _telegramFilePickerStateModel;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerBloc = snoopy<TelegramFilePickerBloc>();
    _telegramFilePickerStateModel =
        _telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
  }

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
            snoopy<TelegramFilePickerBloc>().events.add(SelectGalleryFileEvent(item));
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
                      else if (snoopy<ReusableGlobalFunctions>().isImageFile(item.file?.path ?? ''))
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.file(
                              item.file!,
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                            ),
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
                          child: Center(
                            child: Text(
                              path.extension(item.file?.path ?? ''),
                            ),
                          ),
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
                      Positioned(
                        bottom: -10,
                        right: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity:
                              _telegramFilePickerStateModel.isFileInsidePickedFiles(item) ? 1 : 0,
                          child: AnimatedScale(
                            scale:
                                _telegramFilePickerStateModel.isFileInsidePickedFiles(item) ? 1 : 0,
                            duration: const Duration(milliseconds: 150),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                          style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.memory(
              fit: BoxFit.cover,
              item.videoPreview!,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.play_arrow),
              ),
            ),
          )
        ],
      ),
    );
  }
}
