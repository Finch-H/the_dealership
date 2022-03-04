import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:image_picker/image_picker.dart';
import 'package:the_dealership/Pages/addvehicle.dart';
import 'package:the_dealership/Pages/fleet.dart';
import 'package:the_dealership/Pages/login.dart';
import 'package:the_dealership/Pages/rentals.dart';
import 'package:the_dealership/Pages/testimageupload.dart';
import 'package:the_dealership/allUsers.dart';
import 'package:the_dealership/widgets/bottom_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:the_dealership/widgets/drawer.dart';
import 'package:the_dealership/widgets/homePage/fleets.dart';
import 'package:the_dealership/widgets/homePage/most_rented.dart';
import 'package:unicons/unicons.dart';

import '../configMaps.dart';


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static const String idScreen = "homepage";

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage>with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String _image =
      'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
  String? selectedCarType;
  String? value;
  bool drawerOpen = true;
  late AnimationController loadingController;
  Future getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Name, email address, and profile photo Url
      String name = user.displayName!.trim();
      String email = user.email!.trim();
      //Uri photoUrl = user.getPhotoUrl();

      // Check if user's email is verified
      bool emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // FirebaseUser.getIdToken() instead.
      String uid = user.uid;
    }
  }
  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )
      ..addListener(() {
        setState(() {});
      });


    super.initState();
    _getUserName();
    //
    // user = auth.currentUser!;
    // // Future.delayed(Duration(seconds: 5));
    // // sleep(Duration(seconds: 5));
    // currentUId = user.uid;
    // currentEmail = user.email!;
  }


  String dropdownvalue = '';


  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc((FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {
        var data = value as Map?;
        //uName = data?['FullName'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ;
    final List<String> imageListfleet = [
      "assets/images/yaris.png",
      "assets/images/Lincoln.png",
      "assets/images/mondeo.png",
      "assets/images/bentley02.png",
      "assets/images/Sentra.png",
      "assets/images/corolla.png",
      //'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

//Images for car rental
    final List<String> imageListrental = [
      "assets/images/juke.png",
      "assets/images/v8.png",
      "assets/images/Tahoe.png",
      "assets/images/ford.png",
      "assets/images/lux.png",
      "assets/images/v8.png",

      //'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];


    Size size = MediaQuery
        .of(context)
        .size; //check the size of device
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode

    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),


      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
        child: AppBar(
          shadowColor: Colors.transparent,

          backgroundColor:
          isDarkMode ? const Color(0xff06090d) : const Color(0xfff8f8f8),
          leading: Builder(
              builder: (context) =>
                  IconButton(
                    icon: new Icon(
                      Icons.menu,
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black, //icon bg color
                      size: size.height * 0.025,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    // ),
                    //       bottomOpacity: 0.0,
                    //       elevation: 0.0,
                    //       shadowColor: Colors.transparent,
                    //       backgroundColor:
                    //           isDarkMode ? const Color(0xff06090d) : const Color(0xfff8f8f8),
                    //       //appbar bg color
                    //       leading: Padding(
                    //         padding: EdgeInsets.only(
                    //           left: size.width * 0.05,
                    //         ),
                    //         child: SizedBox(
                    //           height: size.width * 0.1,
                    //           width: size.width * 0.1,
                    //
                    //
                    //          child: Container(
                    //                 decoration: BoxDecoration(
                    //                   color: isDarkMode
                    //                       ? const Color(0xff070606)
                    //                       : Colors.white, //icon bg color
                    //                   borderRadius: const BorderRadius.all(
                    //                     Radius.circular(
                    //                       10,
                    //                     ),
                    //                   ),
                    //                 ),
                    //
                    //
                    //                   child: IconButton(
                    //
                    //
                    //
                    //                     icon:
                    //                     Icon(
                    //                       UniconsLine.bars,
                    //                       color: isDarkMode
                    //                           ? Colors.white
                    //                           : Colors.black, //icon bg color
                    //                       size: size.height * 0.025,
                    //                     ),
                    //             onPressed: ()=> Scaffold.of(context).openDrawer(),
                    //                   ),
                    //                 ),
                    //               ),
                    //        ),
                  )),

          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: size.width * 0.15,
          title: Text("DEALERSHIP",
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              )),

          // Image.asset(
          //   isDarkMode
          //       ? 'assets/icons/SobGOGlight.png'
          //       : 'assets/icons/SobGOGdark.png', //logo
          //   height: size.height * 0.06,
          //   width: size.width * 0.35,
          // ),
          centerTitle: true,
          actions: <Widget>[

          ],
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      //bottomNavigationBar: buildBottomNavBar(1, size, isDarkMode),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xff06090d)
                : const Color(0xfff8f8f8), //background color
          ),
          child: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.04,
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: isDarkMode
                          ? const Color(0xff070606)
                          : Colors.white, //section bg color
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.01,
                          ),
                        ),
                        //intro

                        //fleets
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                ),
                                child: Align(
                                  child: Text(
                                    'DEALERSHIP ',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: size.width * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.00,
                                ),
                                child: Align(
                                  child: Text(
                                    'Choose from our fleet ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.00,
                                  left: size.width * 0.04,
                                  bottom: size.height * 0.025,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.025,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(1),
                                child: CarouselSlider.builder(
                                  itemCount: imageListfleet.length,
                                  options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    height: 230,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    reverse: false,
                                    aspectRatio: 5.0,
                                  ),
                                  itemBuilder: (context, i, id) {
                                    //for onTap to redirect to another screen

                                    return GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Colors.white,
                                            )),
                                        //ClipRRect for image border radius
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          child: Image.asset(
                                            imageListfleet[i],
                                            width: 2700,
                                            //fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        var url = imageListfleet[i];
                                        print(url.toString());
                                      },
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      // MaterialPageRoute(builder: (_) => SignInScreen()),
                                        MaterialPageRoute(
                                            builder: (_) => Fleet()));
                                  },
                                  child: Text(
                                    "Fleet",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.white12,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),

                        //Fleet
                      ],
                    ),
                  ),
                ),

                //RENTAL SLIDER
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    bottom: size.height*0.01,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.01,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.01,
                          left: size.width * 0.04,
                          bottom: size.height * 0.025,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: Align(
                                child: Text(
                                  'DEALERSHIP ',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: size.width * 0.03,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: Align(
                                child: Text(
                                  'Rent A Car now',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(1),
                              child: CarouselSlider.builder(
                                itemCount: imageListrental.length,
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  height: 230,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  reverse: false,
                                  aspectRatio: 5.0,
                                ),
                                itemBuilder: (context, i, id) {
                                  //for onTap to redirect to another screen

                                  return GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Colors.white,
                                          )),
                                      //ClipRRect for image border radius
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        child: Image.asset(
                                          imageListrental[i],
                                          width: 600,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      var url = imageListrental[i];
                                      print(url.toString());
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    // MaterialPageRoute(builder: (_) => SignInScreen()),
                                      MaterialPageRoute(
                                          builder: (_) => RentalPage()));
                                },
                                child: Text(
                                  "Rentals",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: size.width * 0.043,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.white12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                              Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // buildTopBrands(size, isDarkMode),
                // buildMostRented(size, isDarkMode),
                // buildFleets(size, isDarkMode),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/home.png'),
              onPressed: () {},
            ),
            // Add A Car
            IconButton(
              icon: Image.asset('assets/images/plus.png'),
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    addvehicle.idScreen);
              },
            ),
            IconButton(
              icon: Image.asset('assets/images/profile.png'),
              onPressed: () {
               // Navigator.pushNamed(context, testimage.idScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }

  void resetApp() {
    setState(() {
      drawerOpen = true;
    });
  }

  Future getUsername() async {
    final ref = FirebaseDatabase.instance.reference();
    User cuser = await FirebaseAuth.instance.currentUser!;
    final snapshot = await ref.get(); // you
     ref.child('Clients').child(cuser.uid);
    if (snapshot.value != null) {
      userCurrentInfo = Clients.fromSnapshot(snapshot);
      // ref.child('User_data').child(cuser.uid).once().then((DataSnapshot snap) {
      //   final  String userName = snap.value['name'].toString();
      //   print(userName);
      //   return userName;
      // });
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign Out'),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Are you certain you want to Sign Out?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  print('yes');
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                          (route) => false);
                  // Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

}
