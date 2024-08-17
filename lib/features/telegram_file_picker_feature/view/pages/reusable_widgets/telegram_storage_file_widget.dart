import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/global_usages/reusables/reusable_global_functions.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';
import 'package:yahay/injections/injections.dart';
import 'package:path/path.dart' as path;

class TelegramStorageFileWidget extends StatelessWidget {
  final List<TelegramFileImageEntity> list;

  const TelegramStorageFileWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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

