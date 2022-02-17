import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfauja/pages/menu_pages/events/participate_event.dart';
import 'package:myfauja/ui/components/default_button.dart';
import 'package:myfauja/utils/common/size_config.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class EventDetails extends StatefulWidget {
  const EventDetails();

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 4.8,
                  ),
                  child: Image(
                      image: AssetImage('assets/images/logos/logo.png'),
                      width: getProportionateScreenWidth(150),
                      height: getProportionateScreenHeight(150))),
              SizedBox(
                height: 5,
              ),
              Text("6ème congrès de la FA-UJA",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white)),
              Divider(
                color: Color.fromRGBO(204, 242, 201, 1),
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                )),
                child: Text("S'inscrire",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green)),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterToEvent.routeName);
                },
              )
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Center(
                            child: Text("LE PROGRAMME",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20))),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            isScrollable: true,
                            // indicator: RectangularIndicator(
                            //     bottomLeftRadius: 100,
                            //     bottomRightRadius: 100,
                            //     topLeftRadius: 100,
                            //     topRightRadius: 100,
                            //     paintingStyle: PaintingStyle.stroke,),
                            tabs: [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Mercredi 16",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Jeudi 17",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Vendredi 18",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Samedi 19",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                            ]),
                      ]),
                ))),
        Expanded(
            flex: 5,
            child: Container(
              child: TabBarView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  SizedBox(
                                    height: 12,
                                  ),

                                  Text("ACCUEIL DES PARTICIPANTS",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                      Padding(padding: EdgeInsets.only(left:50),
                                        child: Column(children:[
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [

                                                Text("Accueil à l’aéroport,")
                                              ]),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [

                                                Text("Aide aux formalités")
                                              ]),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [

                                                Text("Installation à l’hôtel")
                                              ]),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [

                                                Text("Remise des kits, etc.")
                                              ]),
                                        ]),
                                      ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.mapMarker,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Text("Aéroport | Hotel")
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.clock,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Text("19H - 23H00")
                                            ],
                                          ),
                                        )
                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]))),
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: getProportionateScreenHeight(80),
                                      ),
                                      Text("Diner de bienvenue aux congressistes",
                                          textAlign: TextAlign.center,


                                      ),
                                      SizedBox(
                                        height: getProportionateScreenHeight(50),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [


                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text("23H00")
                                                ],
                                              ),
                                            )
                                          ]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ]))),
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                              color: Colors.white,
                              elevation: 8,
                              child: Center(
                                  child: Text("Soirée Blanche",
                                      )),
                            )),
                      ],
                    ))
                  ],
                ),
                ///////////////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: Column(children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:6.0),
                                    child: Text(
                                        "Arrivée, inscription , retrait des kits et installation des participants",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                Padding(padding: EdgeInsets.only(left:10),
                                    child:Column(children:[
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [Text("Mise en place")]),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Arrivée et installation des autorités")
                                          ]),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Cérémonie d’ouverture \n(Allocution du Président du comité\nd’organisation, du Président sortant\nde la FAJUA et discours \nd’ouverture du Congrès) ")
                                          ]),


                                    ])),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.mapMarker,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Text("Maison de l’Avocat",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ),
                                        Container(

                                          child: Row(
                                            children: [
                                              Text("09h-09h30",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ),

                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]))),
                        Container(
                          width: 250,
                          height: 210,
                          child: Card(
                              color: Colors.white,
                              elevation: 8,
                              child:Center(child:
                              Text("Pause-Café\n09h30-10h00",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18))
                          ),
                          ),
                        ),
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text("10h00 min à 12h00min",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                "1er Panel : le défi de la gouvernance\n et de la redevabilité gagede la paix \nen Afrique Intervenants:\  Me, Avocat)")
                                          ]),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                "1ère Communication : (Me, Avocat)")
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [

                                            Text(
                                                "2ème Communication : (Me, Avocat)")
                                          ]),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("12h 00 min à 14h 00min",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                      "2ème Panel : Les modérateurs : Me, Avocat)",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                      "1ère Communication : Le contentieux minier (Me, Alifa KONE, Avocat au barreau du Mali)",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                      "2ème Communication : Le contentieux des contrats de Partenariat Public-Privé : arbitrage entre investisseurs privés et Etats (Me, Thierno OLORY ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                      "TIGBE, Avocat au Barreau du BENIN)",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                      "Lieu :  Maison de l’Avocat",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("14h 00min à 15h00min",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("Pause Déjeuner",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("15h 00 min à 16h 00min",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                      "3ème Panel : Les modérateurs : Me, Avocat)",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                      "1ère Communication : COVID 19 et pratique du droit en ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                      "Afrique : quels enseignements pour le Jeune Avocat ? ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                      "(Me, Léon Patrice SARR, Avocat au Barreau du SENEGAL, Avocat) ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: Colors.red,
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                      "Lieu : Maison de l’Avocat",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12))
                                                ],
                                              ),
                                            )
                                          ]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ]))),
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                              color: Colors.white,
                              elevation: 8,
                              child: Center(
                                  child: Text(
                                      "17h00min\nRafraichissement – Fin de la 1ère journée",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))),
                            )),
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                              color: Colors.white,
                              elevation: 8,
                              child: Center(
                                  child: Text(
                                      "19h00min à 00h\nCocktail de bienvenue offert par le Président de la FAUJA ( Me Michel E. AHOUMENOU,)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))),
                            )),
                      ],
                    ))
                  ],
                ),
                /////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: Column(children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("09h00 - 10h00",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            "4e Panel:")
                                      ]),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("La Pratique du contentieux \ndu sport en Afriqueune opportunité\n pour le Jeune Avocat.",
                                          textAlign:TextAlign.justify,
                                        style: TextStyle(fontWeight: FontWeight.w500))
                                      ]),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Communicateur: \nMe Daniel Blaise NGOS, \nancien Président de la FAUJA &\n Avocat Barreau du Cameroun)")
                                      ]),
                                  SizedBox(
                                    height: 3,
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text("13h à 14h ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Text("Pause-déjeuner",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        )
                                      ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]))),
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                                color: Colors.white,
                                elevation: 8,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, ),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text("10h30 à 13h00")
                                            ]),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Assemblée Générale \nelective du nouveau Bureau",
                                                  textAlign: TextAlign.center,
                                                  )
                                            ]),

                                        SizedBox(
                                          height: getProportionateScreenHeight(110),
                                        ),
                                      ]),
                                ))),
                        Container(
                            width: 250,
                            height: 210,
                            child: Card(
                                color: Colors.white,
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:20.0, right:1),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text("Après-midi libre ",
                                           ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("20H Diner de Gala")
                                            ]),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [

                                              Text(
                                                  "Lieu : Salle de fête le MAJESTIC")
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [

                                              Text("00H30 à l’aube ")
                                            ]),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.mapMarker,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text("COTONOU BY NIGHT",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12))
                                                  ],
                                                ),
                                              ),
                                            ]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ))),
                      ],
                    ))
                  ],
                ),
                ////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Center(
                      child: Container(
                          width: 240,
                          height: 210,
                          child: Card(
                              color: Colors.white,
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 60.0, right: 20.0),
                                child: Center(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text("09h00 à 17h00",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Journée Touristique")
                                        ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [Text("Visite à AGOUALAN")]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [Text("Déjeuner Champêtre")]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "21H 00min à l’aube :\n Cotonou by night")
                                        ]),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                                ),
                              ))),
                    ))
                  ],
                ),
              ]),
            )),
      ],
    );
  }
}
