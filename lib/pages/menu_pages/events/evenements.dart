import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfauja/pages/menu_pages/events/participate_event.dart';
import 'package:myfauja/utils/next_screen.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Stack(

    );
  }
}

Widget builEventItem(BuildContext context, DocumentSnapshot event){
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: InkWell(
      onTap: ()=> nextScreenReplace(context, RegisterToEvent()),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Ink.image(
                    height: MediaQuery.of(context).size.height * .2,
                    image: NetworkImage("https://i0.wp.com/barreaukm.com/wp-content/uploads/2019/08/UEMOA21.jpg?fit=460%2C400&ssl=1")
                )
              ],
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Congrès des avocats"),
                  Text("Lieu: "),
                  event['dateEvent'] == null
                  ?Column(children: [
                    Text("Date début: 14 Février 2022"),
                    Text("Date fin: 16 Février 2022"),
                  ],): Text("Date : 14 Février 2022"),

                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
