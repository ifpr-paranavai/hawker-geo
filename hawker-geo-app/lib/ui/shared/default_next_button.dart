import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/styles/text.dart';

class DefaultNextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color textColor;
  final List<Color> buttonColors;
  final Color shadowColor;

  const DefaultNextButton(
    this.buttonText, {
    Key? key,
    required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColors = const [Colors.lightGreen, Colors.green],
    this.shadowColor = Colors.lightGreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var materialShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0));
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 5,
          shadowColor: shadowColor,
          shape: materialShape,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  colors: buttonColors,
                  stops: const [0, 1],
                )),
            child: Material(
              shape: materialShape,
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: boldButtonText.copyWith(color: textColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
