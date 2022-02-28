//! EXAMPLE CARS
//TODO: add cars from backend


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';



CollectionReference orderInfo =
FirebaseFirestore.instance.collection('orderInfo');
final user = FirebaseAuth.instance.currentUser;
String? cusName;
String? add;
String? Color;
String?   Seater ;
String? carClass;
String? Condition;
String? Description;
String? Make;
String? Mileage;
String? Price;
String? Region;
String? Transmission;
String? Vin;
String? carPower;
String? CarRating;
String? Category;

CollectionReference _NewVehicles = FirebaseFirestore.instance.collection('NewVehicles');
Future<void> initializeOrder(BuildContext ctx) async {
  List<Map> cars = [
    {
      'carName': 'Hyundai i30 N 2021',
      'carClass': 'Sport',
      'carPower': 265,
      'people': '1-4',
      'bags': '1-3',
      'carImage': 'assets/images/i30n.png',
      'carPrice': 20,
      'isRotated': false,
      'carRating': '5.0',
    },
    {
      'carName': 'Volkswagen Golf ',
      'carClass': 'Economy',
      'carPower': 150,
      'people': '1-5',
      'bags': '1-4',
      'carImage': 'assets/images/golf.png',
      'carPrice': 15,
      'isRotated': true,
      'carRating': '4.2',
    },
    {
      'carName': 'Toyota Yaris \n'
          'COMFORT',
      'carClass': 'City',
      'carPower': 72,
      'people': '1-4',
      'bags': '1-2',
      'carImage': 'assets/images/yaris.png',
      'carPrice': 10,
      'isRotated': false,
      'carRating': '4.8',
    }
  ];
}
void getNewVehicles() async {
  final doc = await FirebaseFirestore.instance
      .collection('NewVehicles')
      .doc(user!.uid)
      .get();

  cusName = doc['Name'];
  Color= doc['Color'];
  Description= doc['Description'];
  Make = doc['Make'];
  Region=doc['Region'];
  Transmission=doc['Transmission'];
  Vin=doc['Vin'];
  Category=doc['Vehicle Category'];
  Region=doc['Region'];
  Price=doc['Price'];
  Condition= doc['Condition'];
  carPower= doc[''];
  carClass= doc[''];
  // add = doc['address1'] + '' + doc['address2'] + '' + doc['address3'];
}