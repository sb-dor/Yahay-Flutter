import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yahay/src/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/src/features/initialization/widgets/dependencies_scope.dart';

class SearchWidget extends StatefulWidget {
  final ValueChanged<String> value;
  final VoidCallback onDispose;

  const SearchWidget({
    super.key,
    required this.value,
    required this.onDispose,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> with SingleTickerProviderStateMixin {
  late AppThemeBloc _appThemeBloc;
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _containerHeight = 55;
  Timer? _setStateTimer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: '');
    _appThemeBloc = DependenciesScope.of(context, listen: false).appThemeBloc;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void timerForSetState() {
    if ((_setStateTimer?.isActive ?? false)) _setStateTimer?.cancel();
    _setStateTimer = Timer(const Duration(milliseconds: 550), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: _containerHeight * _animation.value,
          decoration: BoxDecoration(
            color: _appThemeBloc.theme.value.splashColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              const Icon(Icons.search),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    widget.value(value);
                    timerForSetState();
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    hintText: "Search",
                    isDense: true,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                    widget.onDispose();
                  },
                  icon: const Icon(Icons.close),
                ),
            ],
          ),
        );
      },
    );
  }
}
