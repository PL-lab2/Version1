import 'package:Sociio/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Sociio/screens/onboarding/onboarding.dart';

class Authenticate extends StatelessWidget {
  static String routeName = "/authenticate";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return HomeScreen();
    } else {
      return Onboarding();
    }
  }
}
