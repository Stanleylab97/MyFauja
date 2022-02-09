import 'package:flutter/material.dart';
import 'package:myfauja/ui/components/socal_card.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:myfauja/utils/common/size_config.dart';


import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Créer un compte", style: headingStyle),
                Text(
                  "Veuillez renseigner les champs",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
