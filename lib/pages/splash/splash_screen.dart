import 'package:flutter/material.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/sign_in/sign_in_screen.dart';
import 'package:myfauja/utils/common/size_config.dart';
import 'package:myfauja/pages/splash/components/body.dart';
import 'package:myfauja/utils/next_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  afterSplash() {
    final SignInBloc sb = context.read<SignInBloc>();

      if (sb.isSignedIn == true) {
        redirectUser();
      } else
        gotoSignInPage();

  }



   redirectUser()  {
    Navigator.pushReplacementNamed(context, Dashboard.routeName);
  }

  gotoHomePage() {
    final SignInBloc sb = context.read<SignInBloc>();
    if (sb.isSignedIn == true) {
      sb.getDataFromSp();
    }
    Navigator.pushReplacementNamed(context, Dashboard.routeName);
  }

  gotoSignInPage() {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  @override
  void initState() {
    //afterSplash();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
