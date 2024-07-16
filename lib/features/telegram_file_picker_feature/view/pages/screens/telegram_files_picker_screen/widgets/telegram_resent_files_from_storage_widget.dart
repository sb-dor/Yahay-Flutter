import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _telegramFilePickerStateModel.recentFilesPagination.length,
            itemBuilder: (context, index) {
              final item = _telegramFilePickerStateModel.recentFilesPagination[index];
              return Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          item.fileName ?? '-',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
