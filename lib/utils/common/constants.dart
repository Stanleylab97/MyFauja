import 'package:flutter/material.dart';

import 'size_config.dart';

const kPrimaryColor = Color(0xFF50994A);
const kPrimaryLightColor = Color(0xFF47CB3D);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF47CB3D), Color(0xFF50994A)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Entrez votre e-mail";
const String kInvalidEmailError = "E-mail invalide";
const String kPassNullError = "Mot de passe vide";
const String kShortPassError = "Mot de passe trop court";
const String kMatchPassError = "Mots de non conformes";
const String kNamelNullError = "Veuillez entrer votre nom ";
const String kPhoneNumberNullError = "Numéro de teléphone vide";
const String kSpecialityNullError = "Veuillez définir votre spécialité";


final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
