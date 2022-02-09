import 'package:flutter/material.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/sign_in/sign_in_screen.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:myfauja/utils/common/size_config.dart';
import 'package:provider/provider.dart';

// This is the best practice
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Bienvenue chez vous!",
      "image": "assets/images/intro/right.jpg"
    },
    {
      "text":
          "Echanges & Dialogue",
      "image": "assets/images/intro/network.jpg"
    },
    {
      "text": "Regroupement apolitique d'associations, \n d'unions ou syndicats de jeunes avocats africains",
      "image": "assets/images/intro/syndicat.jpg"
    },
  ];

  afterSplash() {
    final SignInBloc sb = context.read<SignInBloc>();

      if (sb.isSignedIn == true) {
        redirectUser();
      } else
        gotoSignInPage();
    }


  Future redirectUser() async {
    Navigator.pushReplacementNamed(context, Dashboard.routeName);
  }

  gotoHomePage() {
    final SignInBloc sb = context.read<SignInBloc>();
    if (sb.isSignedIn == true) {
      sb.getDataFromSp();
    }
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }


  gotoSignInPage() {
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continuer",
                      press: () {
                        afterSplash();
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
