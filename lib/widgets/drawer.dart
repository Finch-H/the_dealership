import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:the_dealership/assistants/size_config.dart';
import 'package:the_dealership/configMaps.dart';

class MyDrawer extends StatefulWidget {
// const MyDrawer({ required Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  User? user = FirebaseAuth.instance.currentUser;
  String get name => user!.displayName.toString();
  String? get email => user!.email.toString();
  //String?  displayName = FirebaseDatabase.instance.reference().child("Clients").child(uid!).child("name") as String?;


  Future<DatabaseEvent> getData() async{
    var user = await FirebaseAuth.instance.currentUser;
    var uid = firebaseUser!.id;
    final dbRef = FirebaseDatabase.instance.reference().child('Clients').child(user!.uid).child("name");
    return await dbRef.once();
  }

  Future getName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Name, email address, and profile photo Url
      String name = user.uid.trim();
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
              children: const <Widget>[
                Text('Are you certain you want to Sign Out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                print('yes');
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
                // Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
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

  @override
  Widget build(BuildContext context) {

    return Drawer(

        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: DrawerHeader(
                      child: Container(
                        height: 500,
                        child: Column(children:  [
                          CircleAvatar(
                            backgroundColor: Colors.black12,
                            radius: 50,
                            child: Text(
                              'Dealership',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),

                            //Text
                          ),


                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                             name.toString(),
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              email!,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                title: Text('Profile'),
                subtitle: Text("View your account details here"),
                trailing: Icon(Icons.more_vert),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  size: 30,
                ),
                title: Text('About'),
                subtitle: Text("Learn about us "),
                trailing: Icon(Icons.more_vert),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.add,
                  size: 30,
                ),
                title: Text('Orders'),
                subtitle: Text("This is the 1st item"),
                trailing: Icon(Icons.more_vert),
                onTap: () {},
              ),
              const SizedBox(
                height: 25,
              ),
              Column(children: [
                ListTile(
                  onTap: () {
                    _showMyDialog();
                  },
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ]),
              ListTile(
                title: Text('Second item'),
                onTap: () {},
              ),
            ]),
      );

  }
}
