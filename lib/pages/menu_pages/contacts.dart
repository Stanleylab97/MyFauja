import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.only(left: 1, right: 1, top: 100, bottom: 100),
            child :Card(

              elevation: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text("Vous désirez nous joindre ?", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),),
                SizedBox(height: 20,),
                Padding( padding: EdgeInsets.only(left:1, right: 1),
                  child: Column(children:[
                    Text("Site web: www.fauja.org"),
                    SizedBox(height: 20,),

                    Text("Boite mail: contact@fauja.org"),
                    SizedBox(height: 20,),

                    Text("Téléphone: +1 530 347 4607"),
                  ]


                  ),
                ),
          ],),
            )


    ),
      ));
  }
}

