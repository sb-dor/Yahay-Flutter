import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/utils/global_context/global_context.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_events.dart';
import 'package:yahay/injections/injections.dart';

@immutable
class TelegramFilePickerBottomButton {
  final Widget icon;

  const TelegramFilePickerBottomButton(
    this.icon,
  );

  static final _telegramBloc = snoopy<TelegramFilePickerBloc>();

  static List<TelegramFilePickerBottomButton> listOfBottomButtons = [
    TelegramFilePickerBottomButton(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _telegramBloc.events.add(const InitAllPicturesEvent(false));
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
      ),
    ),
    TelegramFilePickerBottomButton(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
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
            onTap: () {},
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
