import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final List<Widget> widgets;

  const CustomFormField({
    super.key,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green[200]!,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
