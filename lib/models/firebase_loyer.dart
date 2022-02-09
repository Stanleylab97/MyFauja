import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfauja/models/loyer_data.dart';

class FirebaseLoyer{
  late LoyerAppData loyerDataGotFromAPI;
  late String imageUrl, status, description,signInProvider;
  late FieldValue lastseen, createdAt;

  late String? uid;

  FirebaseLoyer({required this.loyerDataGotFromAPI,  this.uid, required this.status,required this.description,
    required this.imageUrl, required this.lastseen, required this.signInProvider,required this.createdAt});
}