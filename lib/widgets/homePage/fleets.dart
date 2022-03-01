import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class fleets extends StatefulWidget {
  const fleets({Key? key}) : super(key: key);

  @override
  _fleetsState createState() => _fleetsState();
}

class _fleetsState extends State<fleets> {
  CollectionReference _vote = FirebaseFirestore.instance.collection('Votes');

  CollectionReference _fleet =
  FirebaseFirestore.instance.collection('Fleet');
  CollectionReference _User =
  FirebaseFirestore.instance.collection('Users');


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
