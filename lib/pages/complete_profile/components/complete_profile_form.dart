import 'package:flutter/material.dart';
import 'package:myfauja/blocs/internet_bloc.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/models/loyer_data.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/otp/otp_screen.dart';
import 'package:myfauja/ui/components/custom_surfix_icon.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/ui/components/form_error.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:myfauja/utils/common/size_config.dart';
import 'package:myfauja/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';



class CompleteProfileForm extends StatefulWidget {
  late  String? tag;
  CompleteProfileForm({this.tag});
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? specialite;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool signUpStarted = false;
  bool signUpCompleted = false;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future saveUserData() async {
    final InternetBloc ib = Provider.of<InternetBloc>(context, listen: false);
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await ib.checkInternet();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(new FocusNode());
      await ib.checkInternet();
      if (ib.hasInternet == false) {
        openSnacbar(_scaffoldKey, 'Pas de connexion internet');
      } else {
        setState(() {
          signUpStarted = true;
        });
        sb.completeAccountData(FirebaseAuth.instance.currentUser!.uid, LoyerAppData(nom: lastName.toString(), prenom: firstName.toString(), email: FirebaseAuth.instance.currentUser!.email.toString(), specialite: specialite.toString(), country_code: "", contact: phoneNumber.toString(), cabinet: ""))
             .then((_) async {
          if (sb.hasError == false) {

            afterSignUp();

          } else {
            setState(() {
              signUpStarted = false;
            });
            openSnacbar(_scaffoldKey, sb.errorCode);
          }
        });
      }
    }
  }

  afterSignUp() {
    if (widget.tag == null) {
      Navigator.pushReplacementNamed(context, Dashboard.routeName);
    } else {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continuer",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                saveUserData();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => specialite = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSpecialityNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kSpecialityNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Spécialité",
        hintText: "Entrez votre spécialité",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Numéro de téléphone",
        hintText: "Ex: +229XXXXXXXX",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Nom",
        hintText: "Quel est votre nom?",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Prénoms",
        hintText: "Entrez votre prénoms",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
