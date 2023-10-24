import 'dart:math';

import 'package:chaty/middleware/auth_middleware.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child:
              TextButton(child: const Text("Continue with Google"), onPressed: () {
                AuthMiddleWare().signInWithGoogle(context);
              }),
        ),
      ),
    );
  }
}
