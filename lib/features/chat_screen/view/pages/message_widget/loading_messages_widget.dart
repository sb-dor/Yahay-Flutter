import 'dart:math';

import 'package:flutter/material.dart';

class LoadingMessagesWidget extends StatefulWidget {
  const LoadingMessagesWidget({super.key});

  @override
  State<LoadingMessagesWidget> createState() => _LoadingMessagesWidgetState();
}

class _LoadingMessagesWidgetState extends State<LoadingMessagesWidget> {
  late List<Widget> _widgets;

  @override
  void initState() {
    super.initState();
    final rnd = Random();

    final tempWidgets = [const _RightWidget(), const _LeftWidget()];

    _widgets = List.generate(15, (index) => tempWidgets[rnd.nextInt(2)]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _widgets.length,
      itemBuilder: (context, index) {
        return _widgets[index];
      },
    );
  }
}

class _RightWidget extends StatelessWidget {
  const _RightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 50,
                width: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeftWidget extends StatelessWidget {
  const _LeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 4, left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                width: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
