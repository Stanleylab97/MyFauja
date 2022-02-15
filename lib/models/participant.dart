import 'package:cloud_firestore/cloud_firestore.dart';

class Participant {
  late String? nom,
      prenom,
      barreau_annee,
      pays,
      email,
      contact,
      hotel,
      transport,
      personContact,
      numContact,
      uid;
  late DateTime dateArrive, dateDepart;
  late DateTime? createdAt;
  late String? type;
  Participant(
      {required this.nom,
      required this.prenom,
      this.barreau_annee,
      required this.type,
      required this.pays,
      required this.email,
      required this.contact,
      this.hotel,
      this.uid,
      this.transport,
      required this.dateArrive,
      required this.dateDepart,
      this.personContact,
      this.numContact,
      this.createdAt});

  static Participant fromJson(Map<String, dynamic> json) => Participant(
      uid: json['uid'],
      nom: json['nom'],
      prenom: json['prenom'],
      type: json['type'],
      pays: json['pays'],
      email: json['email'],
      contact: json['phone_number'],
      dateArrive: (json['dateArrival'] as Timestamp).toDate(),
      dateDepart: (json['dateDepart'] as Timestamp).toDate(),
      barreau_annee: "" ,//json['barreau_annee']== null ? "":json['barreau_annee'],
      hotel: json['hotel'],
      transport: json['compagnie_modeTransport'],
      numContact: json['personContact_tel'],
      personContact: "",  //json['personneContact'] == null?"":json['personneContact'],
      createdAt: (json['createdAt'] as Timestamp).toDate());
}
