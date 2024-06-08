import 'package:flutter/material.dart';
import 'package:yahay/features/video_chat_feature/view/bloc/video_chat_feature_bloc.dart';
import 'package:yahay/injections/injections.dart';

class VideoChatFeature extends StatefulWidget {
  const VideoChatFeature({super.key});

  @override
  State<VideoChatFeature> createState() => _VideoChatFeatureState();
}

class _VideoChatFeatureState extends State<VideoChatFeature> {
  late final VideoChatFeatureBloc _videoChatFeatureBloc;

  @override
  void initState() {
    super.initState();
    _videoChatFeatureBloc = snoopy<VideoChatFeatureBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
