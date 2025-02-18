import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahay/src/core/ui_kit/image_loader/image_loaded.dart';
import 'package:yahay/src/features/profile/bloc/profile_bloc.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({super.key});

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileStates>(
      builder: (context, state) {
        return Row(
          children: [
            ImageLoaderWidget(
              url: state.profileStateModel.userModel?.imageUrl ?? '',
              boxFit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                children: [
                  Text("NAME"),
                  Text("PHONE NUMBER"),
                  Text("USERNAME OR EMAIL")
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
