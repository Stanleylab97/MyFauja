import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/launching/login.dart';
import 'package:myfauja/pages/menu_pages/home.dart';
import 'package:myfauja/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  afterSplash() {
    final SignInBloc sb = context.read<SignInBloc>();
    Future.delayed(Duration(milliseconds: 10000)).then((value) {
      if (sb.isSignedIn == true) {
        redirectUser();
      } else
        gotoSignInPage();
    });
  }



  Future redirectUser() async {

      nextScreenReplace(context, Home());

  }

  gotoHomePage() {
    final SignInBloc sb = context.read<SignInBloc>();
    if (sb.isSignedIn == true) {
      sb.getDataFromSp();
    }
    nextScreenReplace(context, Home());
  }

  gotoSignInPage() {
    nextScreenReplace(context, Dashboard());
  }

  @override
  void initState() {
    afterSplash();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image(
                  image: AssetImage("assets/images/logos/logo.png"),
                  height: 240,
                  width: 240,
                  fit: BoxFit.contain,
                )),
            SpinKitSpinningLines(
              duration: Duration(microseconds: 3000),
              color: Colors.blue,
              size: 50.0,
            ),

            Divider(height: 5,
            color: Colors.blue,
              indent: 100,
            endIndent: 100,),
            SizedBox(height: 5),
            Text("POWERED BY STANLEYLAB",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),),


          ],
        ) );
  }
}


