import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDisplayError extends StatelessWidget {
  final String? error;

  const CustomDisplayError({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (error == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        SvgPicture.asset('assets/icons/Error.svg'),
        const SizedBox(width: 10),
        Text(error!),
      ],
    );
  }
}
