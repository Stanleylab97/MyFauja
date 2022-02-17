import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfauja/utils/common/size_config.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(left: 1, right: 1, top: 50, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20,  bottom: 19),
                child: Image(
                    image: AssetImage('assets/images/logos/logo.png'),
                    width: getProportionateScreenWidth(200),
                    height: getProportionateScreenHeight(200))),
            Text(
              "Vous désirez nous joindre ?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.desktop,
                        color: Colors.green
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Text("Site web: www.fauja.org"),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.mailBulk,color: Colors.green),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Text("Boite mail: contact@fauja.org"),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.phoneAlt, color: Colors.green,),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Text("Téléphone: +1 530 347 4607"),
                  ],
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}
