import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfauja/models/participant.dart';
import 'package:myfauja/utils/common/size_config.dart';

class Participants extends StatefulWidget {
  const Participants({Key? key}) : super(key: key);

  @override
  _ParticipantsState createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  String type = "";
  int n = 1;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Events')
        .doc("congresVI")
        .collection("inscriptions")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        n = querySnapshot.docs.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Stream<List<Participant>> readAvocats() => FirebaseFirestore.instance
    //     .collection('Events')
    //     .doc("congresVI")
    //     .collection("inscriptions")
    //     .snapshots()
    //     .map((snapshot) => snapshot.docs
    //         .map((doc) => Participant.fromJson(doc.data()))
    //         .toList());

    // String getInscrits() {
    //   String x = FirebaseFirestore.instance
    //       .collection('Events')
    //       .doc("congresVI")
    //       .collection("inscriptions")
    //       .snapshots()
    //       .length
    //       .toString();
    //   return x;
    // }

    Widget buildParticipant(Participant participant) => ListTile(
          leading: CircleAvatar(
            child: FaIcon(FontAwesomeIcons.user),
          ),
          title: Text("${participant.nom} ${participant.prenom}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${participant.pays}"),
              Text("${participant.createdAt!.toIso8601String()}")
            ],
          ),
        );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 4.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 28.0,
            onPressed: () {},
          ),
          title: Text(
            'Participants',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Column(children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Events')
                        .doc("congresVI")
                        .collection("inscriptions")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.connectionState == ConnectionState.none) {
                        return Center(
                            child: Text("Pas d'inscrits pour le moment"));
                      }

                      // if (snapshot.hasError) {
                      //   return Center(
                      //       child: Text('Erreur de lecture'));
                      // }

                      final participants = snapshot.data;

                      //  print("TEST PARTICIPANTS ${participants?.size}");

                      //return Center(child: Text("En cours de maintenance"));
                      return ListView.builder(
                          itemCount: participants?.size,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: FaIcon(FontAwesomeIcons.user),
                              ),
                              title: Text(
                                  "${participants!.docs[index]['nom']} ${participants!.docs[index]['prenom']}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${participants!.docs[index]['pays']}"),
                                  Text(
                                      "${participants!.docs[index]['createdAt'].toDate().toString()}")
                                ],
                              ),
                            );
                          });
                    })),
          ]),
        ));
  }
}
