import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:myfauja/pages/menu_pages/events/event_details.dart';
import 'package:myfauja/pages/menu_pages/events/participate_event.dart';
import 'package:myfauja/pages/profile/components/profile_pic.dart';
import 'package:myfauja/utils/common/size_config.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/home";

  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 1 ;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child:Text(
      'Fil d\'actualité',
      style: optionStyle,
    )),

    RegisterToEvent(),

    ProfilePic()
    // Center(child:Text(
    //   'Profil',
    //   style: optionStyle,
    // ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(10)
                  , vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Actualité',
                ),

                GButton(
                  icon: FontAwesomeIcons.calendar,
                  text: 'Evenement',
                  textStyle: TextStyle(fontSize: 14),
                ),

                GButton(
                  icon: LineIcons.user,
                  text: 'Mon compte',
                  textStyle: TextStyle(fontSize: 14),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}