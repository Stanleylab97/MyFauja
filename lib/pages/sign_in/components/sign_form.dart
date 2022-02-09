import 'package:flutter/material.dart';
import 'package:myfauja/blocs/internet_bloc.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/pages/dashboard.dart';
import 'package:myfauja/pages/forgot_password/forgot_password_screen.dart';
import 'package:myfauja/pages/login_success/login_success_screen.dart';
import 'package:myfauja/ui/components/custom_surfix_icon.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/ui/components/form_error.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:myfauja/utils/common/helper/keyboard.dart';
import 'package:myfauja/utils/common/size_config.dart';
import 'package:myfauja/utils/next_screen.dart';
import 'package:myfauja/utils/snackbar.dart';
import 'package:provider/provider.dart';

class SignForm extends StatefulWidget {
  late final String? tag;
  SignForm({this.tag});
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? email;
  String? password;
  bool signInStart = false;
  bool signInComplete = false;

  final List<String?> errors = [];

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

  handleSignInwithemailPassword() async {
    final InternetBloc ib = Provider.of<InternetBloc>(context, listen: false);
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await ib.checkInternet();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      await ib.checkInternet();
      if (ib.hasInternet == false) {
        openSnacbar(_scaffoldKey, 'no internet');
      } else {
        setState(() {
          signInStart = true;
        });
        sb.signInwithEmailPassword(email, password).then((_) async {
          if (sb.hasError == false) {

            sb
                .getUserDatafromFirebase(sb.firebaseLoyer.uid)
                //.then((value) => sb.guestSignout())
                .then((value) => sb
                .saveDataToSP()
                .then((value) => sb.setSignIn().then((value) {
              setState(() {
                signInComplete = true;
              });
              afterSignIn();
            })));
          } else {
            setState(() {
              signInStart = false;
            });
            openSnacbar(_scaffoldKey, sb.errorCode);
          }
        });
      }
    }
  }

  afterSignIn() {
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          signInStart? Center(child: CircularProgressIndicator()): DefaultButton(
            text: "Connexion",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() {
                  signInStart=true;
                });
                handleSignInwithemailPassword();
                setState(() {
                  signInStart=false;
                });
              }
            },
          ),
        ],
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
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
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
        labelText: "E-mail",
        hintText: "Entrez votre email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
