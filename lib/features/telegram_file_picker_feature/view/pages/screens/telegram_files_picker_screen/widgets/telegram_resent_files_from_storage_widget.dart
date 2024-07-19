import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/telegram_file_image_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/state_model/telegram_file_picker_state_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';

class TelegramResentFilesFromStorageWidget extends StatefulWidget {
  final TelegramFilePickerBloc telegramFilePickerBloc;

  const TelegramResentFilesFromStorageWidget({
    super.key,
    required this.telegramFilePickerBloc,
  });

  @override
  State<TelegramResentFilesFromStorageWidget> createState() =>
      _TelegramResentFilesFromStorageWidgetState();
}

class _TelegramResentFilesFromStorageWidgetState
    extends State<TelegramResentFilesFromStorageWidget> {
  late final TelegramFilePickerStateModel _telegramFilePickerStateModel;

  @override
  void initState() {
    super.initState();
    _telegramFilePickerStateModel =
        widget.telegramFilePickerBloc.states.value.telegramFilePickerStateModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900.withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent files",
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 15),
          //
          // here should be the list of only files not images or videos
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _telegramFilePickerStateModel.recentFilesPagination.length,
            itemBuilder: (context, index) {
              final item = _telegramFilePickerStateModel.recentFilesPagination[index];
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
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
          ),
        ],
      ),
    );
  }
}
