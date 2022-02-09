import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfauja/pages/menu_pages/events/components/kkiapay.dart';
import 'package:myfauja/ui/components/custom_surfix_icon.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/ui/components/form_error.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


import '../../../utils/common/size_config.dart';
class RegisterToEvent extends StatefulWidget {
  const RegisterToEvent({Key? key}) : super(key: key);

  @override
  _RegisterToEventState createState() => _RegisterToEventState();
}

class _RegisterToEventState extends State<RegisterToEvent> {
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
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Inscription pour participer", style: TextStyle(
                  fontSize: getProportionateScreenWidth(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                )),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text(
                  "Il suffit de remplir le formulaire",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}




class CompleteProfileForm extends StatefulWidget {
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

  bool typeAvocat=true;


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
           CountryCodePicker(
              onChanged: (c){
                print(c.name);
              },
              initialSelection: 'BJ',
              showFlag: true,
              showOnlyCountryWhenClosed: true,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),

          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),


          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Participer",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => typeAvocat?kkiapay_avocat:kkiapay_stagiaire),
                );              }
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

  DateTimeField buildArrivee(){
    final format = DateFormat("yyyy-MM-dd");

    return DateTimeField(
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2022),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(DateTime.now().year,DateTime.now().month,2));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime:
            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }
}


