import 'package:flutter/material.dart';

class TelegramBottomSenderButton extends StatefulWidget {
  const TelegramBottomSenderButton({super.key});

  @override
  State<TelegramBottomSenderButton> createState() =>
      _TelegramBottomSenderButtonState();
}

class _TelegramBottomSenderButtonState
    extends State<TelegramBottomSenderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor, //Theme.of(context).cardColor
      padding: const EdgeInsets.all(10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions_outlined),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(
                          context,
                        ).cardColor, //Theme.of(context).cardColor
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Add a caption",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              width: 50,
              height: 50,
              child: const Center(child: Icon(Icons.send, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
