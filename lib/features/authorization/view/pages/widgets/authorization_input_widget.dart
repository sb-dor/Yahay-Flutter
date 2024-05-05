import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorizationInputWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;

  const AuthorizationInputWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
  });

  @override
  State<AuthorizationInputWidget> createState() => _AuthorizationInputWidgetState();
}

class _AuthorizationInputWidgetState extends State<AuthorizationInputWidget> {
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          // color: Colors.red,
          height: 60,
          child: TextField(
            onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
            controller: widget.controller,
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              // isDense: true,
              focusedBorder: _border,
              enabledBorder: _border,
              errorBorder: _border,
              disabledBorder: _border,
            ),
          ),
        ),
      ],
    );
  }
}
