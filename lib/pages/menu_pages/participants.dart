import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfauja/models/participant.dart';

class Participants extends StatefulWidget {
  const Participants({Key? key}) : super(key: key);

  @override
  _ParticipantsState createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  var transactionHeading = Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 5,
    ).copyWith(
      top: 5,
      bottom: 5,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Transactions',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF151C2A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(5.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Point des inscriptons',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Total perçu:')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Participant>> readAvocats() => FirebaseFirestore.instance
        .collection('Events')
        .doc("congresVI")
        .collection("inscriptions").where("type", isEqualTo: "")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Participant.fromJson(doc.data()))
            .toList());

    Stream<List<Participant>> readStagiaire() => FirebaseFirestore.instance
        .collection('Events')
        .doc("congresVI")
        .collection("inscriptions").where("type", isEqualTo: "")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Participant.fromJson(doc.data()))
            .toList());

    Stream<List<Participant>> readAutres() => FirebaseFirestore.instance
        .collection('Events')
        .doc("congresVI")
        .collection("inscriptions")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Participant.fromJson(doc.data()))
        .toList());

    Widget buildParticipant(Participant participant) => ListTile(
          leading: CircleAvatar(
            child: FaIcon(FontAwesomeIcons.user),
          ),
          title: Text("${participant.nom} ${participant.nom}"),
          subtitle: Text(
              "${participant.pays} ${participant.createdAt!.toIso8601String()}"),
        );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              'Point des inscriptions',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 5, right:5, top: 5),
            child: Column(children: [
              _buildHeader(),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, ),
                      child: TabBar(
                        indicator: BubbleTabIndicator(
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          indicatorHeight: 40.0,
                          indicatorColor: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.white,
                        tabs: <Widget>[
                          Text('Avocats'),
                          Text('Stagiaires', style: TextStyle(fontSize: 12)),
                          Text('Autres'),
                        ],
                      ))),
              SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * .604,
                child: TabBarView(
                  children: [
                    Expanded(
                        child: StreamBuilder<List<Participant>>(
                            stream: readAvocats(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Veuillez réessayer plus tard. Un léger soucis de connexion');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Center(
                                    child:
                                        Text("Pas d'inscrits pour le moment"));
                              }

                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Something went wrong'));
                              }

                              final participants = snapshot.data!;

                              return ListView(
                                  children: participants
                                      .map(buildParticipant)
                                      .toList());
                            })),
                    Expanded(
                        child: StreamBuilder<List<Participant>>(
                            stream: readAvocats(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Veuillez réessayer plus tard. Un léger soucis de connexion');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Center(
                                    child:
                                        Text("Pas d'inscrits pour le moment"));
                              }

                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Something went wrong'));
                              }

                              final participants = snapshot.data!;

                              return ListView(
                                  children: participants
                                      .map(buildParticipant)
                                      .toList());
                            })),
                    Expanded(
                        child: StreamBuilder<List<Participant>>(
                            stream: readAvocats(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Veuillez réessayer plus tard. Un léger soucis de connexion');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Center(
                                    child:
                                    Text("Pas d'inscrits pour le moment"));
                              }

                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Something went wrong'));
                              }

                              final participants = snapshot.data!;

                              return ListView(
                                  children: participants
                                      .map(buildParticipant)
                                      .toList());
                            })),
                  ],
                ),
              )
            ]),
          )),
    );
  }
}
