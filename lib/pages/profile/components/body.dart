import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/menu_pages/participants.dart';
import 'package:myfauja/pages/sign_in/sign_in_screen.dart';
import 'package:myfauja/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../blocs/theme_bloc.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SignInBloc sb = context.read<SignInBloc>();
    const String _url = 'http://fauja.org';

    void _launchURL() async {
      if (!await launch(_url)) throw 'Could not launch $_url';
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Mon compte",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Site web FAUJA",
            icon: "assets/icons/Bell.svg",
              press: (){
                _launchURL();
              }
          ),
          ProfileMenu(
            text: "Contacts Fauja",
            icon: "assets/icons/Settings.svg",
          ),
          ProfileMenu(
            text: "Liste des participants",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Participants()),
              );
            },
          ),
          ProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/Log out.svg",
            press: () async {

              Navigator.pop(context);
              await context
                  .read<SignInBloc>()
                  .userSignout()
                  .then(
                      (value) => context.read<SignInBloc>().afterUserSignOut())
                  .then((value) {
                if (context.read<ThemeBloc>().darkTheme == true) {
                  context.read<ThemeBloc>().toggleTheme();
                }
                nextScreenCloseOthers(context, SignInScreen());
              });
            },
          ),
        ],
      ),
    );
  }
}
