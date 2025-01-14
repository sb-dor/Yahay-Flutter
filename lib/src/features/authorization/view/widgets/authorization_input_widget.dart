import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';

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
  final _border = InputBorder.none;

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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextFormField(
            validator: (value) {
              if ((value ?? '').isEmpty) return Constants.fieldCanNotBeEmpty;
              return null;
            },
            onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
            controller: widget.controller,
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              // isDense: true,
              // border: _border,
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
