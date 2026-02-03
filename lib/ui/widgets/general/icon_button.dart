import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;
  final Icon icon;

  const ButtonWithIcon({
    super.key,
    required this.message,
    required this.onPressed,
    required this.icon,
  });
  @override
  Widget build(Object context) {
    return Tooltip(
      message: message,
      child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}
