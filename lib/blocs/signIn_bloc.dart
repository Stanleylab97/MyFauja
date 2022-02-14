import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfauja/models/firebase_loyer.dart';
import 'package:myfauja/models/loyer_data.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends ChangeNotifier {
  SignInBloc() {
    checkSignIn();
    initPackageInfo();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String defaultUserImageUrl =
      'https://www.oxfordglobal.co.uk/nextgen-omics-series-us/wp-content/uploads/sites/16/2020/03/Jianming-Xu-e5cb47b9ddeec15f595e7000717da3fe.png';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  late String _errorCode;
  String get errorCode => _errorCode;

  late FirebaseLoyer? _firebaseLoyer;
  FirebaseLoyer? get firebaseLoyer => _firebaseLoyer;

  //String nom,prenom, email, specialite,country_code, contact, cabinet,imageUrl, status, description, usercategory;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  late String timestamp;

  String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;

  void initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    _packageName = packageInfo.packageName;
    notifyListeners();
  }

  Future signUpwithEmailPassword(email, userPassword) async {
    try {
      final User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: userPassword,
      ))
          .user;
      assert(user != null);
      assert(await user!.getIdToken() != null);
      _hasError = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      notifyListeners();
    }
  }

  Future completeAccountData(String uid, LoyerAppData newloyerData) async {
    try {
      saveToFirebase(newloyerData);
      saveDataToSP();
      _hasError = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      notifyListeners();
    }
  }

  Future signInwithEmailPassword(userEmail, userPassword) async {
    try {
      final User? user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: userEmail, password: userPassword))
          .user;
      assert(user != null);
      assert(await user?.getIdToken() != null);
      final User? currentUser = _firebaseAuth.currentUser;
      //print(currentUser);
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          final SharedPreferences sp = await SharedPreferences.getInstance();

          await sp.setString('uid', documentSnapshot['surname']);
          await sp.setString('nom', documentSnapshot['surname']);
          await sp.setString('prenom', documentSnapshot['firstname']);
          await sp.setString('email', documentSnapshot['email']);
          await sp.setString('contact', documentSnapshot['contact']);
          await sp.setString('imageUrl', documentSnapshot['profileUrl']);
          await sp.setString('sign_in_provider', documentSnapshot['provider']);
          await sp.setString('description', documentSnapshot['description']);
          await sp.setString('cabinet', documentSnapshot['cabinet']);
          await sp.setString('country', documentSnapshot['country']);
          await sp.setString('specialite', documentSnapshot['speciality']);
          await sp.setString('userCategory', documentSnapshot['userCategory']);
          await sp.setString('status', documentSnapshot['status']);

        } else {
          print('Document does not exist on the database');
        }
      });

      _hasError = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      notifyListeners();
    }
  }

  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await firestore.collection('users').doc(_firebaseLoyer!.uid).get();
    if (snap.exists) {
      print('User Exists');
      return true;
    } else {
      print('new user');
      return false;
    }
  }

  Future saveToFirebase(LoyerAppData newloyerData) async {
    this._firebaseLoyer = FirebaseLoyer(
        loyerDataGotFromAPI: LoyerAppData(
            nom: newloyerData.nom,
            prenom: newloyerData.prenom,
            email: newloyerData.email,
            specialite: newloyerData.specialite,
            country_code: "Bénin",
            contact: newloyerData.contact,
            cabinet: ""),
        uid: FirebaseAuth.instance.currentUser!.uid.toString(),
        status: "Offline",
        description: "Une bioographie",
        imageUrl: defaultUserImageUrl,
        signInProvider: "email",
        usercategory: "USER");
    print(_firebaseLoyer!.uid);
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_firebaseLoyer!.uid);
    var userData = {
      'surname': _firebaseLoyer!.loyerDataGotFromAPI.nom,
      'firstname': _firebaseLoyer!.loyerDataGotFromAPI.prenom,
      'email': _firebaseLoyer!.loyerDataGotFromAPI.email,
      'uid': _firebaseLoyer!.uid,
      'status': _firebaseLoyer!.status,
      'lastseen': FieldValue.serverTimestamp(),
      'profileUrl': _firebaseLoyer!.imageUrl,
      'contact': _firebaseLoyer!.loyerDataGotFromAPI.contact,
      'country': _firebaseLoyer!.loyerDataGotFromAPI.country_code,
      'cabinet': _firebaseLoyer!.loyerDataGotFromAPI.cabinet,
      'description': _firebaseLoyer!.description,
      'createdAt': FieldValue.serverTimestamp(),
      'speciality': _firebaseLoyer!.loyerDataGotFromAPI.specialite,
      'provider': _firebaseLoyer!.signInProvider,
      'userCategory': _firebaseLoyer!.usercategory
    };

    await ref.set(userData);
    print('Data save to FB');
  }

  Future getTimestamp() async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    timestamp = _timestamp;
  }

  Future saveDataToSP() async {
    print("TEST: ENTER IN SHARE PREF");

    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString('uid', _firebaseLoyer!.uid.toString());
    await sp.setString('nom', _firebaseLoyer!.loyerDataGotFromAPI.nom);
    await sp.setString('prenom', _firebaseLoyer!.loyerDataGotFromAPI.prenom);
    await sp.setString('email', _firebaseLoyer!.loyerDataGotFromAPI.email);
    await sp.setString('contact', _firebaseLoyer!.loyerDataGotFromAPI.contact);
    await sp.setString('imageUrl', _firebaseLoyer!.imageUrl);
    await sp.setString(
        'sign_in_provider', _firebaseLoyer!.signInProvider.toString());
    await sp.setString('description', _firebaseLoyer!.description);
    await sp.setString('cabinet', _firebaseLoyer!.loyerDataGotFromAPI.cabinet);
    await sp.setString(
        'country', _firebaseLoyer!.loyerDataGotFromAPI.country_code);
    await sp.setString(
        'specialite', _firebaseLoyer!.loyerDataGotFromAPI.specialite);
    await sp.setString('userCategory', _firebaseLoyer!.usercategory);

    print("TEST: REGISTER IN SHARE PREF");
  }

  Future getDataFromSp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _firebaseLoyer!.loyerDataGotFromAPI.nom = sp.getString('nom').toString();
    _firebaseLoyer!.loyerDataGotFromAPI.prenom =
        sp.getString('prenom').toString();
    _firebaseLoyer!.loyerDataGotFromAPI.contact =
        sp.getString('contact').toString();
    _firebaseLoyer!.loyerDataGotFromAPI.country_code =
        sp.getString('country').toString();
    _firebaseLoyer!.loyerDataGotFromAPI.cabinet =
        sp.getString('cabinet').toString();
    _firebaseLoyer!.loyerDataGotFromAPI.specialite =
        sp.getString('specialite').toString();
    _firebaseLoyer!.imageUrl = sp.getString('imageUrl').toString();
    _firebaseLoyer!.uid = sp.getString('uid').toString();
    _firebaseLoyer!.description = sp.getString('description').toString();
    _firebaseLoyer!.usercategory = sp.getString('userCategory').toString();
    _firebaseLoyer!.signInProvider =
        sp.getString('sign_in_provider').toString();

    notifyListeners();
  }

  Future getUserDatafromFirebase(uid) async {
    print("TEST: USER LOGGED IN");

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snap) {
      var avocat = LoyerAppData(
          nom: snap['surname'],
          prenom: snap['firstname'],
          email: snap['email'],
          specialite: snap['speciality'],
          country_code: snap['country'],
          contact: snap['contact'],
          cabinet: snap['cabinet']);
      print("TEST : $avocat");

      _firebaseLoyer = FirebaseLoyer(
          loyerDataGotFromAPI: avocat,
          uid: snap['uid'],
          status: snap['status'],
          description: snap['description'],
          imageUrl: snap['profileUrl'],
          signInProvider: snap['provider'],
          usercategory: snap['userCategory']);
    }).onError((error, stackTrace) {
      print("TEST error: " + error.toString());
    });
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }

  Future userSignout() async {
    if (_signInProvider == 'email') {
      await _firebaseAuth.signOut();
    }
  }

  Future afterUserSignOut() async {
    await userSignout().then((value) async {
      await clearAllData();
      _isSignedIn = false;
      notifyListeners();
    });
  }

  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future updateUserProfile(String newName, String newImageUrl) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseLoyer!.uid)
        .update({'firstname': newName, 'imageUrl': newImageUrl});

    sp.setString('firstname', newName);
    sp.setString('imageUrl', newImageUrl);
    _firebaseLoyer!.loyerDataGotFromAPI.nom = newName;
    _firebaseLoyer!.imageUrl = newImageUrl;

    notifyListeners();
  }

  Future<int> getTotalUsersCount() async {
    final String fieldName = 'count';
    final DocumentReference ref =
        firestore.collection('item_count').doc('users_count');
    DocumentSnapshot snap = await ref.get();
    if (snap.exists == true) {
      int itemCount = snap[fieldName] ?? 0;
      return itemCount;
    } else {
      await ref.set({fieldName: 0});
      return 0;
    }
  }

  Future increaseUserCount() async {
    await getTotalUsersCount().then((int documentCount) async {
      await firestore
          .collection('item_count')
          .doc('users_count')
          .update({'count': documentCount + 1});
    });
  }
}
