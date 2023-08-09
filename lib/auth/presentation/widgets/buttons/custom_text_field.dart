import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool borderBottom;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.borderBottom = true,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
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
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 17, color: Colors.black54),
        decoration: InputDecoration(
          // isDense: true,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          errorText: errorMessage,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
