import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfauja/models/loyer_data.dart';

class FirebaseLoyer{
  late LoyerAppData loyerDataGotFromAPI;
  late String imageUrl, status, description, usercategory;

  late String? uid,signInProvider;

  FirebaseLoyer({required this.loyerDataGotFromAPI,  this.uid, required this.status,required this.description,
    required this.imageUrl,  this.signInProvider,required this.usercategory});
}