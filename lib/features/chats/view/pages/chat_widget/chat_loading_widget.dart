import 'package:flutter/material.dart';
import 'package:yahay/core/app_settings/app_theme/app_theme_bloc.dart';
import 'package:yahay/core/global_usages/widgets/shimmer_loader.dart';
import 'package:yahay/injections/injections.dart';

class ChatLoadingWidget extends StatefulWidget {
  const ChatLoadingWidget({super.key});

  @override
  State<ChatLoadingWidget> createState() => _ChatLoadingWidgetState();
}

class _ChatLoadingWidgetState extends State<ChatLoadingWidget> {

  late AppThemeBloc _appThemeBloc;

  @override
  void initState() {
    super.initState();
    _appThemeBloc = snoopy<AppThemeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      isLoading: true,
      mode: _appThemeBloc.theme.value,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          return IntrinsicHeight(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
