import 'package:flutter/material.dart';
import 'package:myfauja/pages/sign_up/sign_up_screen.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:myfauja/utils/common/size_config.dart';


class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pas de compte? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(18)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Créer un compte",
            style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(18),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
