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
  String type="";
  int n=1;

@override
  void initState() {
  FirebaseFirestore.instance
      .collection('Events')
      .doc("congresVI")
      .collection("inscriptions")
      .get().then((QuerySnapshot querySnapshot){
    setState(() {
      n=querySnapshot.docs.length;
    });

  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Participant>> readAvocats() => FirebaseFirestore.instance
        .collection('Events')
        .doc("congresVI")
        .collection("inscriptions")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Participant.fromJson(doc.data()))
            .toList());

   String getInscrits()  {

    String x= FirebaseFirestore.instance
         .collection('Events')
         .doc("congresVI")
         .collection("inscriptions")
         .snapshots().length.toString();
     return x;
    }



    Widget buildParticipant(Participant participant) => ListTile(
          leading: CircleAvatar(
            child: FaIcon(FontAwesomeIcons.user),
          ),
          title: Text("${participant.nom} ${participant.prenom}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${participant.pays}"),
              Text("${participant.createdAt!.toIso8601String()}")
            ],
          ),
        );

    return DefaultTabController(
      length: 2,
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
              //_buildHeader(),
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
                          Text('Participants'),
                          Text('Encaissements', style: TextStyle(fontSize: 12)),
                        ],
                      ))),
              SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * .604,
                child: TabBarView(
                  children: [

                    Flex(
                      direction: Axis.vertical,
                      children:[ Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Events')
                                  .doc("congresVI")
                                  .collection("inscriptions")
                                  .snapshots(),
                              builder: (context, snapshot) {


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

                                // if (snapshot.hasError) {
                                //   return Center(
                                //       child: Text('Erreur de lecture'));
                                // }

                                final participants = snapshot.data;

                              //  print("TEST PARTICIPANTS ${participants?.size}");

                                //return Center(child: Text("En cours de maintenance"));
                                return ListView.builder(
                                    itemCount: participants?.size,
                                    itemBuilder: (context, index){
                                    return ListTile(
                                      leading: CircleAvatar(
                                        child: FaIcon(FontAwesomeIcons.user),
                                      ),
                                      title: Text("${participants!.docs[index]['nom']} ${participants!.docs[index]['prenom']}"),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${participants!.docs[index]['pays']}"),
                                          Text("${participants!.docs[index]['createdAt'].toDate().toString()}")
                                        ],
                                      ),
                                    );
                                });
                              })),
                    ]),

                    Flex(
                      mainAxisSize: MainAxisSize.min,
                      direction: Axis.vertical,
                      children:[ Expanded(
                          child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                              Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: CircleAvatar(
                                  radius: getProportionateScreenHeight(70),
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    radius: getProportionateScreenHeight(60),
                                    backgroundColor: Colors.white,
                                    child:
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 50,
                                      child: FaIcon(FontAwesomeIcons.getPocket, color: Colors.green, size: 40,),
                                    ))))),

                                  SizedBox(height: getProportionateScreenHeight(50),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20 ),
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nombre inscrits : $n',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text('Total perçu: 1000000 FCFA',style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),)
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                      ]
                    )

                  ],
                ),
              )
            ]),
          )),
    );
  }
}
