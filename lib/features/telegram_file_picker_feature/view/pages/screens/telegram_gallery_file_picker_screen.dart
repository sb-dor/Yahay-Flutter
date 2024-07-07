import 'package:flutter/material.dart';

class TelegramGalleryFilePickerScreen extends StatefulWidget {
  final ScrollController parentScrollController;

  const TelegramGalleryFilePickerScreen({
    super.key,
    required this.parentScrollController,
  });

  @override
  State<TelegramGalleryFilePickerScreen> createState() => _TelegramGalleryFilePickerScreenState();
}

class _TelegramGalleryFilePickerScreenState extends State<TelegramGalleryFilePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.parentScrollController,
      children: [
        Text("1")
      ],
    );
  }
}
