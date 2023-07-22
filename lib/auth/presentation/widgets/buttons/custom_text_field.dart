import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool borderBottom;
  final String hintText;

  const CustomTextField({
    super.key,
    this.borderBottom = true,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: borderBottom
            ? Border(
                bottom: BorderSide(color: Colors.grey[400]!),
              )
            : null,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
