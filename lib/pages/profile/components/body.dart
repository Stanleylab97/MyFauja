import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/sign_in/sign_in_screen.dart';
import 'package:myfauja/utils/next_screen.dart';
import 'package:provider/provider.dart';
import '../../../blocs/theme_bloc.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Paramètres",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Aide",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/Log out.svg",
            press: () async {
              final SignInBloc sb = context.read<SignInBloc>();
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
