import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          const Center(
            child: _AvatarProfile(),
          ),
          _ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            onPressed: () => context.push('/profile'),
          ),
          _ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            onPressed: () => context.push('/notifications'),
          ),
          _ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            onPressed: () {},
          ),
          _ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            onPressed: () {},
          ),
          _ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            onPressed: ref.read(authProvider.notifier).logout,
          ),
        ],
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final String text;
  const _ProfileMenu({
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color.fromARGB(255, 230, 231, 235),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              colorFilter:
                  const ColorFilter.mode(Colors.green, BlendMode.srcIn),
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class _AvatarProfile extends StatelessWidget {
  const _AvatarProfile();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/2.jpg"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
