import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  late String? uid;
  late String title, theme, lieu;
  late FieldValue? dateDebut, dateFin;
  late FieldValue? dateEvent;

  Event({this.uid, required this.title, required this.theme, required this.lieu, this.dateEvent, this.dateDebut, this.dateFin });

}