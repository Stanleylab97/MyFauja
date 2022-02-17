import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:myfauja/blocs/internet_bloc.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/models/participant.dart';
import 'package:myfauja/pages/menu_pages/events/components/success_screen.dart';
import 'package:myfauja/ui/components/custom_surfix_icon.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/ui/components/form_error.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../models/firebase_loyer.dart';
import '../../../utils/common/size_config.dart';

class RegisterToEvent extends StatefulWidget {
  static String routeName = "/registerEvent";

  const RegisterToEvent({Key? key}) : super(key: key);

  @override
  _RegisterToEventState createState() => _RegisterToEventState();
}

class _RegisterToEventState extends State<RegisterToEvent> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Text("Inscription au congrès",
                      style: TextStyle(
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
      ),
    );
    ;
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
  String? pays = "Bénin";
  String? phoneNumber, personne_contact_tel;
  String? bareau_annee,
      adresse,
      email,
      transport,
      hotel,
      personne_contact,
      date_depart,
      date_arrivee;
  bool typeAvocat = true;
  String dropdownValue = 'Avocat inscrit au barreau';
  late Participant p;
  String idInscription="";
  CollectionReference inscriptions = FirebaseFirestore.instance
      .collection('Events')
      .doc("congresVI")
      .collection("inscriptions");

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
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    final InternetBloc ib = Provider.of<InternetBloc>(context, listen: false);
    FirebaseLoyer? loyer=sb.getUserDatafromFirebaseInApp(FirebaseAuth.instance.currentUser!.uid);


    // void sucessCallback(response, context) {
    //   print(response);
    //   Navigator.pop(context);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => SuccessScreen(
    //         nom: lastName.toString(),
    //         amount: response['amount'],
    //         transactionId: response['transactionId'],
    //         numero_Inscrption:
    //         DateFormat('yyyyMMddHHmmss').format(DateTime.now()),
    //       ),
    //     ),
    //   );
    // }

    // final kkiapay_avocat = KKiaPay(
    //   amount: 2,
    //   phone: phoneNumber,
    //   data: 'Congres VI',
    //   sandbox: false,
    //   apikey: '0866da3bacd24a50be86e5bed2854c77e80bcfce',
    //   callback: sucessCallback,
    //   name: lastName.toString() + " " + firstName.toString(),
    //   theme: "#50994a",
    // );
    //
    // final kkiapay_stagiaire = KKiaPay(
    //   amount: 1,
    //   phone: phoneNumber,
    //   data: 'Congres VI',
    //   sandbox: false,
    //   apikey: '0866da3bacd24a50be86e5bed2854c77e80bcfce',
    //   callback: sucessCallback,
    //   name: "JOHN DOE",
    //   theme: "#50994a",
    // );

    registerForEvent() async {
      await ib.checkInternet();
      if (ib.hasInternet == false) {
        Flushbar(
          message: 'Pas de connexion internet',
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
        );
      } else {
        // Call the user's CollectionReference to add a new user
        inscriptions.add({
          'nom': lastName!.toUpperCase(), // John Doe
          'prenom': firstName, // Stokes and Sons
          'bareau_annee': bareau_annee,
          'type': dropdownValue,
          'email': email,
          'phone_number': phoneNumber,
          'pays': pays,
          'hotel': hotel,
          'compagnie_modeTransport': transport,
          'dateArrival': date_arrivee,
          'dateDepart': date_depart,
          'personneContact': personne_contact,
          'personContact_tel': personne_contact_tel,
          'createdAt': FieldValue.serverTimestamp(),
          'uid': FirebaseAuth.instance.currentUser!.uid
        }).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                SuccessScreen(prenom: firstName.toString(),nom: lastName.toString(), numero_Inscrption: value.id)),
          );
        }).catchError((error) {
          Flushbar(
            message: "Une erreur s'est produite pendant l'enregistrement",
            icon: Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.blue[300],
            ),
            duration: Duration(seconds: 5),
            leftBarIndicatorColor: Colors.blue[300],
          )..show(context);
        });
      }
    }



    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: loyer?.loyerDataGotFromAPI.nom,
              onSaved: (newValue) => lastName = newValue,
              decoration: InputDecoration(
                labelText: "Nom",
                hintText: "Quel est votre nom?",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            TextFormField(
              initialValue: loyer?.loyerDataGotFromAPI.prenom,
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
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child: Text('Catégorie d\'avocat:',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Expanded(
                  flex: 7,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.green,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if (newValue == "Avocat inscrit au barreau")
                          typeAvocat = true;
                        else
                          typeAvocat = false;
                      });
                    },
                    items: <String>[
                      'Avocat inscrit au barreau',
                      'Avocat stagiaire',
                      'Autre'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            buildBarreauFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 4,
                    child: Text('Votre pays d\'origne:',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Expanded(
                    flex: 6,
                    child: CountryCodePicker(
                      searchDecoration: InputDecoration(
                        labelText: "Pays d'origine",
                        hintText: "Votre pays",
                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (c) {
                        print(c.name);
                        pays = c.name;
                      },
                      initialSelection: 'BJ',
                      showFlag: true,
                      showOnlyCountryWhenClosed: true,
                    )),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildAddressFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            TextFormField(
              initialValue: loyer?.loyerDataGotFromAPI.email,
              onSaved: (newValue) => email = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: 'Entrez votre e-mail');
                }
                return null;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: "E-mail vide");
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Adresse e-mail",
                hintText: "Ex: cossi@exemple.com",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            TextFormField(
              initialValue: loyer?.loyerDataGotFromAPI.contact,
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
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildTransportFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildHotelFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildArrivee(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildDepart(),
            buildPersonneContactFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildContactPhoneNumberFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "S'inscrire",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  registerForEvent();

                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => adresse = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSpecialityNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Pas d'adresse");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Adresse",
        hintText: "Ex: Cotonou, Ganhi",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildBarreauFormField() {
    return TextFormField(
      onSaved: (newValue) => bareau_annee = newValue,

        onChanged: (value) {
          if (value.isEmpty) {
            setState(() {
              bareau_annee="";
            });

          }
          return null;
      },

      decoration: InputDecoration(
        labelText: "Barreau & Année serment",
        hintText: "Ex: Barreau de Cotonou/2016",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }



  TextFormField buildTransportFormField() {
    return TextFormField(
      onSaved: (newValue) => transport = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Qui assure votre transport ?');
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Transport vide");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Compagnie/mode de transport",
        hintText: "Ex: Les Bagnoles/Voiture",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildHotelFormField() {
    return TextFormField(
      onSaved: (newValue) => hotel = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Où séjournez-vous ?');
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Champ hotel vide");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Hotel réservé",
        hintText: "Ex: Golden Tulipe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }


  TextFormField buildContactPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => personne_contact_tel = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Indiquez le numéro du contact");
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
        labelText: "Numéro de votre contact",
        hintText: "Ex: +229XXXXXXXX",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }



  TextFormField buildPersonneContactFormField() {
    return TextFormField(
      onSaved: (newValue) => personne_contact = newValue,
      decoration: InputDecoration(
        labelText: "Personne à contacter",
        hintText: "Ex: TOTO Marvin",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }


  DateTimeField buildArrivee() {
    final format = DateFormat("dd/MM/yyyy kk:mm");

    return DateTimeField(
      decoration: InputDecoration(
        labelText: "Date d'arrivée",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: FaIcon(FontAwesomeIcons.planeArrival),
      ),
      onChanged: (value) {
        print(value);
        date_arrivee = value.toString();
      },
      initialValue: DateTime.now(),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2022),
            initialDate: currentValue ?? DateTime.now(),
            lastDate:
                DateTime(DateTime.now().year, DateTime.now().month + 1, 25));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }

  DateTimeField buildDepart() {
    final format = DateFormat("dd/MM/yyyy kk:mm");

    return DateTimeField(
      decoration: InputDecoration(
        labelText: "Date de départ",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: FaIcon(FontAwesomeIcons.planeDeparture),
      ),
      onChanged: (value) {
        print(value);
        date_depart = value.toString();
      },
      initialValue: DateTime.now(),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2022),
            initialDate: currentValue ?? DateTime.now(),
            lastDate:
                DateTime(DateTime.now().year, DateTime.now().month + 1, 25));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }
}
