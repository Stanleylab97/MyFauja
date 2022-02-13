import 'package:flutter/material.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/menu_pages/events/event_details.dart';
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
      "text": "QUI SOMMES-NOUS?",
      "textbody": "Constituée à Dakar, la Fédération Africaine des Associations et Unions de Jeunes Avocats est un regroupement apolitique d'associations, d'unions ou syndicats de jeunes avocats africains.",
      "image": "assets/images/intro/justice.png"
    },
    {
      "text": "Notre vocation",
      "textbody": "Notre vocation est de contribuer à l’amélioration des conditions d’exercice de la profession par les jeunes avocats, de promouvoir les actions nécessaires à la protection de la personne humaine, de ses libertés ainsi qu’au respect des droits de la défense, de contribuer à l’avènement, au maintien et à l’amélioration de l’état de droit.",
      "image": "assets/images/intro/balance.png"
    },
    {
      "text": "NOS MISSIONS",
      "textbody": "La FA-UJA travail sur les problèmes affectant la profession d’Avocat dans son ensemble, et plus spécialement les jeunes Avocats, qui peuvent rencontrer des difficultés particulières liées à leur installation ou à leur exercice professionnel.",
      "image": "assets/images/intro/splash_11.png"
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
              flex: 4,
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
                  textbody: splashData[index]['textbody'],
                ),
              ),
            ),
            Expanded(
              flex: 1,
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
                        //Navigator.pushReplacementNamed(context, Dashboard.routeName);

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
