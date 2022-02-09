import 'package:flutter/widgets.dart';
import 'package:myfauja/pages/complete_profile/complete_profile_screen.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/forgot_password/forgot_password_screen.dart';
import 'package:myfauja/pages/login_success/login_success_screen.dart';
import 'package:myfauja/pages/menu_pages/home.dart';
import 'package:myfauja/pages/profile/profile_screen.dart';
import 'package:myfauja/pages/sign_in/sign_in_screen.dart';
import 'package:myfauja/pages/sign_up/sign_up_screen.dart';
import 'package:myfauja/pages/splash/splash_screen.dart';



// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
 // OtpScreen.routeName: (context) => OtpScreen(),
  Dashboard.routeName: (context) => Dashboard(),
  //DetailsScreen.routeName: (context) => DetailsScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
