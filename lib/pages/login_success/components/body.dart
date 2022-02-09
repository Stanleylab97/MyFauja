import 'package:flutter/material.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/menu_pages/home.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/utils/common/size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Connexiion réussie Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () {
              Navigator.pushNamed(context, Dashboard.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
