import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';

@immutable
class TelegramFilePickerBottomButton {
  final Widget icon;

  const TelegramFilePickerBottomButton(
    this.icon,
  );

  static List<TelegramFilePickerBottomButton> listOfBottomButtons(
    final TelegramFilePickerBloc telegramBloc,
  ) =>
      [
        TelegramFilePickerBottomButton(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                telegramBloc.add(
                  const TelegramFilePickerEvents.changeStateToAllPicturesEvent(),
                );

                // telegramBloc.events.add(const InitAllFilesEvent(initFilePickerState: false));

                telegramBloc.resetDragScrollSheet();
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Gallery",
              style: GoogleFonts.aBeeZee(
                fontSize: 16,
              ),
            )
          ],
        )),
        TelegramFilePickerBottomButton(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  telegramBloc.add(const TelegramFilePickerEvents.changeStateToAllFilesState());
                  telegramBloc.resetDragScrollSheet();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.file_open_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "File",
                style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        TelegramFilePickerBottomButton(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  telegramBloc.resetDragScrollSheet();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.file_open_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Musics",
                style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ];
}
