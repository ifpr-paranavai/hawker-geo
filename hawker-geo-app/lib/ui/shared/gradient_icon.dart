import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/styles/color.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final double rectSize;
  final List<Color> gradientColors;
  final double startGradient;
  final double endGradient;

  const GradientIcon({
    Key? key,
    required this.icon,
    this.iconSize,
    required this.rectSize,
    this.startGradient = 0,
    this.endGradient = 0.55,
    this.gradientColors = const [kPrimaryColor, kSecondColor],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        child: Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, rectSize, rectSize);
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
          stops: [startGradient, endGradient],
        ).createShader(rect);
      },
    );
  }
}
