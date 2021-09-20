import 'package:Sociio/screens/home_screen/home_screen.dart';
import 'package:Sociio/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Sociio/screens/onboarding/onboarding.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'helper/sharedpref_helper.dart';

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
