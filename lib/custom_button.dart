import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Text child;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double height;
  final double width;
  final Color? color;
  // final Icon?;
//Icon(Icons.arrow_back)
  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.height = 80,
    this.width = 90,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30,
          ),
          child: child,
        ),
      ),
    );
  }
}
