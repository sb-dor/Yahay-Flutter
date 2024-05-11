import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/global_data/models/user_model/user_functions.dart';
import 'package:yahay/core/global_usages/widgets/image_loader/image_loaded.dart';

class AddContactUserWidget extends StatelessWidget {
  final User user;

  const AddContactUserWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => [],
      child: Container(
        color: Colors.transparent,
        child: IntrinsicHeight(
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: ImageLoaderWidget(
                  url: user.imageUrl ?? '',
                  errorWidget: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Center(
                      child: Text(
                        UserFunctions.fromEntity(user).getFirstAndLastLetterOfName(),
                        style: GoogleFonts.aBeeZee(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name ?? '',
                      style: GoogleFonts.aBeeZee(fontSize: 15),
                    ),
                    Text(
                      "Last seen 3000 y.a",
                      style: GoogleFonts.aBeeZee(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
              ),
              IconButton(onPressed: () => [], icon: const Icon(Icons.person_add_alt))
            ],
          ),
        ),
      ),
    );
  }
}
