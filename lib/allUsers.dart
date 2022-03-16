import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'configMaps.dart';

 Future<void> getUsername(BuildContext context) async {
   FirebaseAuth auth = FirebaseAuth.instance;

   final ref = FirebaseDatabase.instance.reference();
   User? cuser = await auth.currentUser;
   ref.child("Clients").child(cuser!.uid);
   // firebaseUser = await FirebaseAuth.instance.currentUser!;
   String userId = firebaseUser!.uid;
   DatabaseReference userRef = FirebaseDatabase.instance.reference().child(
       "Clients").child(userId);

   final snapshot = await userRef.get(); // you
   if (snapshot.value != null) {
     userCurrentInfo = Clients.fromSnapshot(snapshot);
   }


 }
DatabaseReference db = FirebaseDatabase.instance.reference().child("Users");

User? firebaseUser;


User? currentfirebaseUser;


class Clients {
  String? key;
  String? id;
  String? email;
  String? name ;
  String? phone;


  Clients({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,


  });

  Clients.fromSnapshot(DataSnapshot dataSnapShot) {
    id = dataSnapShot.key!;
    var data = dataSnapShot.value as Map?;
    name = data?["name"];
    // client_name = dataSnapShot.value["client_name"];
    // client_phone = dataSnapShot.value["client_phone"];
    // created_at = dataSnapShot.value[" created_a"];
    // driver_id = dataSnapShot.value!["driver_id"];
    // driver_name=dataSnapShot.value["driver_name"];
    // driver_phone=dataSnapShot.value["driver_phone"];
    // dropoff_address=dataSnapShot.value["dropoff_address"];
    // pickup_address=dataSnapShot.value["pickup_address"];
    // ride_type=dataSnapShot.value["ride_type"];
  }
  Clients? _userInfo;

  Clients? get userInfo => _userInfo;


}

