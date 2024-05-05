import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/global_usages/widgets/splash_button_clicker.dart';

class OtherAuthorizationButtonWidget extends StatelessWidget {
  final Widget icon;
  final String text;

  const OtherAuthorizationButtonWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SplashButtonClicker(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 5),
            Text(
              text,
              style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
      onTap: () => [],
    );
  }
}
