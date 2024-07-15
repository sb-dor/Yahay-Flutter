import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelegramResentFilesFromStorageWidget extends StatefulWidget {
  const TelegramResentFilesFromStorageWidget({super.key});

  @override
  State<TelegramResentFilesFromStorageWidget> createState() =>
      _TelegramResentFilesFromStorageWidgetState();
}

class _TelegramResentFilesFromStorageWidgetState
    extends State<TelegramResentFilesFromStorageWidget> {
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
        ],
      ),
    );
  }
}
