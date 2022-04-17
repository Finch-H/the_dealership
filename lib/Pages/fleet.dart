import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_dealership/Pages/login.dart';

class Fleet  extends StatefulWidget {
  const Fleet({Key? key}) : super(key: key);

  @override
  _fleetState createState() => _fleetState();
}

class _fleetState extends State<Fleet> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool drawerOpen = true;
  CollectionReference _fleets =
  FirebaseFirestore.instance.collection('Fleets');
  CollectionReference _User =
  FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {


return  Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: true,
      // elevation: 0,
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Fleets',
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: FlatButton(
            onPressed: () {
              _showMySignout();
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),

      ],
    ),
    body: StreamBuilder(
        stream: _fleets.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Fleets')
                    .get(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (streamSnapshot.error != null) {
                      return const Center(
                        child: Text('An error has occurred'),
                      );
                    } else {
                      final List<DocumentSnapshot> documents =
                          streamSnapshot.data!.docs;
                      return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                            return SizedBox(
                              height: 180,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  color: Colors.white54,
                                  child: Column(
                                    children: [

                                //   Container(
                                //   padding: EdgeInsets.all(10.0),
                                //   child: FutureBuilder(
                                //     future: getImages(),
                                //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                //       if (snapshot.connectionState == ConnectionState.done) {
                                //         return ListView.builder(
                                //             shrinkWrap: true,
                                //             itemCount: snapshot.data?.docs.length,
                                //             itemBuilder: (BuildContext context, int index) {
                                //               return ListTile(
                                //                 contentPadding: EdgeInsets.all(8.0),
                                //                 title:
                                //                 Text(snapshot.data!.docs[index]["name"]),
                                //                 leading: Image.network(
                                //                     snapshot.data?.docs[index]["url"],
                                //                     fit: BoxFit.fill),
                                //               );
                                //             });
                                //       } else if (snapshot.connectionState == ConnectionState.none) {
                                //         return Text("No data");
                                //       }
                                //       return CircularProgressIndicator();
                                //     },
                                //   ),
                                // ),

                                  /// code here


                                    Container(
                                        child: Row(

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset('assets/images/yaris.png',
                                                  width: 200.0,
                                                  height: 120.0,
                                                  ),
                                            ),
                                            Column(
                                                children: [
                                               Text(
                                                documents[index].get('Make')+ documents[index].get("Model"),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),

                                                  Text(
                                                    documents[index].get('Condition'),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold),
                                                  ),

                                                ]
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                  children: [
                                                    Text(
                                                      documents[index].get('CarSeater'),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    ),

                                                    Text(
                                                      documents[index].get('Color'),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    ),

                                                  ]
                                              ),
                                            ),
                                ],
                                        )


                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }
                });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }));;

  }

  Future<QuerySnapshot> getImages() {
    return FirebaseFirestore.instance.collection("images").get();
  }

    void resetApp() {
    setState(() {
      drawerOpen = true;
    });
  }
  Future<void> _showMySignout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
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
                  Navigator.pushReplacementNamed(context, SignInScreen.idScreen);

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
