import 'package:flutter/material.dart';
import 'package:myfauja/blocs/internet_bloc.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/complete_profile/complete_profile_screen.dart';
import 'package:myfauja/ui/components/custom_surfix_icon.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/ui/components/form_error.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:myfauja/utils/common/size_config.dart';
import 'package:myfauja/utils/next_screen.dart';
import 'package:myfauja/utils/snackbar.dart';
import 'package:provider/provider.dart';



class SignUpForm extends StatefulWidget {
  late  String? tag;
  SignUpForm({this.tag});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String? email;
  late String? password;
  String? conform_password;
  final List<String?> errors = [];
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

  Future handleSignUpwithEmailPassword() async {
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
        sb
            .signUpwithEmailPassword(email, password)
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
      Navigator.pushReplacementNamed(context, CompleteProfileScreen.routeName);
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Enregister",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                handleSignUpwithEmailPassword();
               // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirmation mot de passe",
        hintText: "Confirmez le mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >=6) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mot de passe",
        hintText: "Entrez votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Entrez votre e-mail",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
