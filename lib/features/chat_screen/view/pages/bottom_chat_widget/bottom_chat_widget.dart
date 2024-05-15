import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomChatWidget extends StatelessWidget {
  const BottomChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(onPressed: () => [], icon: const FaIcon(FontAwesomeIcons.fileClipboard)),
          const SizedBox(width: 5),
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        isDense: true,
                        hintText: "Message",
                        contentPadding: EdgeInsets.all(0),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () => [],
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
