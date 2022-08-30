import 'package:flutter/material.dart';

class RegisterDropdownButton<T> extends StatelessWidget {
  final T? value;
  final Color shadowColor;
  final IconData? icon;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;

  const RegisterDropdownButton({
    Key? key,
    this.shadowColor = Colors.lightGreen,
    this.icon,
    this.items,
    this.onChanged,
    this.value,
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
          child: DropdownButtonFormField<T>(
            decoration: const InputDecoration(border: InputBorder.none),
            iconEnabledColor: shadowColor,
            value: value,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
