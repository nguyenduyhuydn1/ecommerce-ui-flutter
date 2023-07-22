import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.icon, required this.onPressed});

  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 231, 231, 231),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon, width: 15),
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 10),
    //   decoration: BoxDecoration(
    //     color: Colors.green[200],
    //     shape: BoxShape.circle,
    //   ),
    //   child: Material(
    //     color: Colors.transparent,

    //     child: InkWell(
    //       onTap: () {},
    //       child: Container(
    //         padding: const EdgeInsets.all(20),
    //         decoration: BoxDecoration(
    //           color: Colors.green[200],
    //           shape: BoxShape.circle,
    //         ),
    //         child: SvgPicture.asset(icon, width: 20),
    //       ),
    //     ),
    //   ),
    // );
  }
}
