import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        GoRouter.of(context).go('/');
      } else {
        GoRouter.of(context).go('/counters');
      }
    });

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
