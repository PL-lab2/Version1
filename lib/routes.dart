import 'package:flutter/widgets.dart';
import 'package:Sociio/screens/register_success/register_success_screen.dart';
import 'package:Sociio/screens/sign_in/sign_in_screen.dart';
import 'package:Sociio/screens/sign_up/sign_up_screen.dart';
import 'package:Sociio/screens/splash/splash.dart';
import 'package:Sociio/screens/onboarding/onboarding.dart';
import 'package:Sociio/screens/home_screen/home_screen.dart';
import 'package:Sociio/screens/forgot_password/forgot_password.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  SignInScreen.routeName: (context) => SignInScreen(),
  RegisterSuccessScreen.routeName: (context) => RegisterSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  Onboarding.routeName: (context) => Onboarding(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
};
