import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final WidgetRef ref;
  final VoidCallback func;
  final BuildContext context;
  GoogleAuthService(
      {required this.ref, required this.context, required this.func});

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (result.user != null) {
      await ref.read(authProvider.notifier).registerUser(
            result.user?.email ?? '',
            result.user != null ? '${result.user?.uid}secretkey' : '',
            result.user?.displayName ?? '',
            service: true,
          );
      // func();
    }
    // 112809209090625878915
    return result;
  }
}
