import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_dealership/widgets/bottom_nav_bar.dart';
import 'package:the_dealership/widgets/bottom_nav_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dealership/widgets/drawer.dart';
import 'package:the_dealership/widgets/homePage/fleets.dart';
import 'package:the_dealership/widgets/homePage/most_rented.dart';
import 'package:the_dealership/widgets/homePage/top_brands.dart';
import 'package:unicons/unicons.dart';

class Fleet  extends StatefulWidget {
  const Fleet({Key? key}) : super(key: key);

  @override
  _fleetState createState() => _fleetState();
}

class _fleetState extends State<Fleet> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool drawerOpen = true;

  @override
  Widget build(BuildContext context) {

    CollectionReference _fleets =
    FirebaseFirestore.instance.collection('Fleets');
    CollectionReference _User =
    FirebaseFirestore.instance.collection('Users');
return Container();

  }



  void resetApp() {
    setState(() {
      drawerOpen = true;
    });
  }
}
