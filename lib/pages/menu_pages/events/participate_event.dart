import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:myfauja/blocs/signIn_bloc.dart';
import 'package:myfauja/models/participant.dart';
import 'package:myfauja/pages/menu_pages/events/components/kkiapay.dart';
import 'package:myfauja/pages/menu_pages/events/components/success_screen.dart';
import 'package:myfauja/ui/components/custom_surfix_icon.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/ui/components/form_error.dart';
import 'package:myfauja/utils/common/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:provider/provider.dart';

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
  String? pays="Bénin";
  String? phoneNumber, personne_contact_tel;
  String? bareau_annee, adresse,email,transport,hotel,personne_contact,date_depart,date_arrivee;
  bool typeAvocat = true;
  String dropdownValue = 'Avocat inscrit au barreau';
  late Participant p;
  late String idInscription;
  CollectionReference inscriptions = FirebaseFirestore.instance.collection('Events').doc("congresVI").collection("inscriptions");




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
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);

    Future<void> registerForEvent() {
      // Call the user's CollectionReference to add a new user
      return inscriptions
          .add({
        'nom': p.nom, // John Doe
        'prenom': p.prenom, // Stokes and Sons
        'bareau_annee': p.barreau_annee ,
        'type': p.type,
        'email': p.email,
        'phone_number': p.contact,
        'pays': p.pays,
        'hotel': p.hotel,
        'compagnie_modeTransport': p.transport,
        'dateArrival':p.dateArrive,
        'dateDepart': p.dateDepart,
        'personneContact':p.personContact,
        'personContact_tel': p.numContact,
        'createdAt': FieldValue.serverTimestamp()
      })
          .then((value) {
        setState(() {
          idInscription=value.id;
        });
      })
          .catchError((error){
        Flushbar(
          message: "Une erreur s'est produite",
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

    void sucessCallback(response, context) {
      print(response);
      Navigator.pop(context);
      registerForEvent();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            participant:p,
            amount: response['amount'],
            transactionId: response['transactionId'],
            numero_Inscrption: idInscription,
          ),
        ),
      );
    }

    final kkiapay_avocat = KKiaPay(
      amount: 2,
      phone: phoneNumber,
      data: 'Congres VI',
      sandbox: false,
      apikey: '0866da3bacd24a50be86e5bed2854c77e80bcfce',
      callback: sucessCallback,
      name: lastName.toString()+" "+firstName.toString(),
      theme: "#50994a",
    );

    final kkiapay_stagiaire = KKiaPay(
      amount: 1,
      phone: phoneNumber,
      data: 'Congres VI',
      sandbox: false,
      apikey: '0866da3bacd24a50be86e5bed2854c77e80bcfce',
      callback: sucessCallback,
      name: "JOHN DOE",
      theme: "#50994a",
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(sb),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(sb),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBarreauFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DropdownButton<String>(
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
                if(newValue == 'Avocat inscrit au barreau')
                  typeAvocat=true;
                else
                  typeAvocat=false;
              });
            },
            items: <String>['Avocat inscrit au barreau', 'Avocat stagiaire']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Expanded(
                  flex:4,
                  child: Text('Votre pays d\'origne:', style: TextStyle(fontWeight: FontWeight.w500))),
              Expanded(
                  flex: 6,
                  child :CountryCodePicker(

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
          Divider(color: Colors.black,),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(sb),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(sb),
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
                 p=Participant(nom: lastName, prenom: firstName, type: dropdownValue, barreau_annee: bareau_annee, pays: pays, email: email, contact: phoneNumber, hotel: hotel, transport: transport,dateArrive: date_arrivee, dateDepart: date_depart, personContact: personne_contact, numContact: personne_contact_tel);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => typeAvocat?kkiapay_avocat:kkiapay_stagiaire
                      ),
                );
              }
            },
          ),
        ],
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
        if (value.isNotEmpty) {
          removeError(error: 'Veuillez définir votre barreau');
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Barreau vide");
          return "";
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

  TextFormField buildEmailFormField(SignInBloc sb) {
    return TextFormField(
      initialValue: sb.firebaseLoyer.loyerDataGotFromAPI.email,
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

  TextFormField buildPhoneNumberFormField(SignInBloc sb) {
    return TextFormField(
      initialValue:  sb.firebaseLoyer.loyerDataGotFromAPI.contact,
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

  TextFormField buildLastNameFormField(SignInBloc sb) {
    return TextFormField(
      initialValue: sb.firebaseLoyer.loyerDataGotFromAPI.nom,
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

  TextFormField buildPersonneContactFormField() {
    return TextFormField(

      onSaved: (newValue) => lastName = newValue,
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

  TextFormField buildFirstNameFormField(SignInBloc sb) {
    return TextFormField(
      initialValue: sb.firebaseLoyer.loyerDataGotFromAPI.prenom,
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

  DateTimeField buildArrivee() {
    final format = DateFormat("dd/MM/yyyy kk:mm");

    return DateTimeField(
      decoration: InputDecoration(
        labelText: "Date d'arrivée",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: FaIcon(FontAwesomeIcons.planeArrival) ,
      ),
      onChanged: (value) {
        print(value);
        date_arrivee=value.toString();
      },
    initialValue: DateTime.now(),
      format: format,

      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2022),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month, 2));
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
        suffixIcon: FaIcon(FontAwesomeIcons.planeDeparture) ,
      ),
      onChanged: (value) {
        print(value);
        date_depart=value.toString();
      },
      initialValue: DateTime.now(),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2022),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month+1, 25));
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

