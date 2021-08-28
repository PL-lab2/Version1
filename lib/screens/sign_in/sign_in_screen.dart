import 'package:flutter/material.dart';
import 'package:Sociio/size_config.dart';
import 'components/body.dart';
import 'package:Sociio/methods.dart';
import 'package:Sociio/screens/home_screen/home_screen.dart';
import 'package:Sociio/autheticate.dart';
import 'package:Sociio/screens/sign_up/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Body(),
    );
  }
}
