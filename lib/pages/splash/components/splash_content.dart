import 'package:flutter/material.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:myfauja/utils/common/size_config.dart';



class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.textbody,
    this.image,
  }) : super(key: key);
  final String? text, textbody, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        children: <Widget>[
          Spacer(),
          Text(
            "MyFauja",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(36),
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text!,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: getProportionateScreenHeight(10),),
          Text(
            textbody!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),

          Spacer(flex: 2),
          Image.asset(
            image!,
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235),
          ),
        ],
      ),
    );
  }
}
