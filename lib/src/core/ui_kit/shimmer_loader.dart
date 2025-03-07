import 'package:flutter/material.dart';

const _shimmerLightGradient = LinearGradient(
  colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
const _shimmerDarkGradient = LinearGradient(
  colors: [Color(0xFF2C2C3E), Color(0xFF1E1E1E), Color(0xFF2C2C3E)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class ShimmerLoader extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final ThemeData mode;

  const ShimmerLoader({
    super.key,
    required this.isLoading,
    required this.child,
    required this.mode,
  });

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        if (widget.mode.brightness == Brightness.dark) {
          return _shimmerDarkGradient.createShader(bounds);
        } else {
          return _shimmerLightGradient.createShader(bounds);
        }
      },
      child: widget.child,
    );
  }
}
