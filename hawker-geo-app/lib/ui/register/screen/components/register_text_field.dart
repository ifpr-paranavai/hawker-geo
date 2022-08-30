import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawker_geo/ui/shared/gradient_icon.dart';

class RegisterTextField extends StatelessWidget {
  final Color shadowColor;
  final String? hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const RegisterTextField({
    Key? key,
    this.shadowColor = Colors.lightGreen,
    this.hintText,
    this.icon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var materialShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        shadowColor: shadowColor,
        shape: materialShape,
        child: Padding(
          padding: EdgeInsets.only(left: icon != null ? 8 : 25, right: 8),
          child: TextFormField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            controller: controller,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                icon: icon != null
                    ? Material(
                        elevation: 4,
                        color: Colors.transparent,
                        shadowColor: shadowColor.withOpacity(0.5),
                        shape: materialShape,
                        child: GradientIcon(
                          rectSize: 30,
                          icon: icon!,
                          gradientColors: const [
                            Colors.lightGreen,
                            Color.fromARGB(255, 42, 159, 45)
                          ],
                        ),
                      )
                    : null,
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                suffixIcon: suffixIcon,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 1,
                  minHeight: 1,
                )),
          ),
        ),
      ),
    );
  }
}
