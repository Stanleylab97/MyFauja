
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myfauja/utils/common/size_config.dart';

class EventDetails extends StatefulWidget {
  const EventDetails();
  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    //TabController _tabController=TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Color.fromRGBO(81, 153, 74, 1),
          leading: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 15,
                    ),
                    child: Image(image: AssetImage('assets/images/logos/logo.png'), width: getProportionateScreenWidth(80),height: getProportionateScreenHeight(80))
                  ),
                  Text("6èm CONGRES \n DE LA FA-UJA"),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(204, 242, 201, 1),
      body: _Body(),
    );
  }
}


class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(81, 153, 74, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),

              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Placeholder(),
          ),
        ),
      ],
    );
  }
}