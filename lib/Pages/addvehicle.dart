



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_dealership/allUsers.dart';
import 'package:the_dealership/configMaps.dart';

class addvehicle extends StatefulWidget {
  const addvehicle({Key? key}) : super(key: key);
  static String idScreen = 'addVehicle';

  @override
  _addvehicleState createState() => _addvehicleState();
}

class _addvehicleState extends State<addvehicle> {
  String? _VehicledropDownValue;
  String? _RegiondropDownValue;
  String? _ConditiondropDownValue;
  String? _TransmissiondropDownValue;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;
  String make = '';
  String Color = '';
  String Milleage = '';
  String VIN = '';
  String Description = '';
  String Price = '';
  String Name = "";


  List<Clients>? Client;
  Clients?  client;
  DatabaseReference? clientdb;


  @override
  void initState() {
    super.initState();
    Client = [];
    // user = users("","", "") ;
    final FirebaseDatabase database = FirebaseDatabase.instance;
    clientdb = database.reference().child('Ride Requests');
    clientdb?.onChildAdded.listen(_onEntryAdded);
    clientdb?.onChildChanged.listen(_onEntryChanged);

  }

  _onEntryAdded(dynamic event) {
    setState(() {
      Client?.add(Clients.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(dynamic event) {
    var old = Client?.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      Client?[Client!.indexOf(old!)] = Clients.fromSnapshot(event.snapshot);
    });
  }
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add to the Fleet or Rental'),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                  child: DropdownButton(
                    hint: _VehicledropDownValue == null
                        ? Text('Choose A Category')
                        : Text(
                            _VehicledropDownValue!,
                            style: TextStyle(color: Colors.blue),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blue),
                    items: [
                      'Fleet',
                      'Rental',
                    ].map(
                      (Vehicleval) {
                        return DropdownMenuItem<String>(
                          value: Vehicleval,
                          child: Text(Vehicleval),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _VehicledropDownValue = val.toString();
                        },
                      );
                    },
                  ),
                ),

                //Upload an Image
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GridView.builder(
                            itemCount: imageFileList!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              return Image.file(
                                File(imageFileList![index].path),
                                fit: BoxFit.cover,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          selectImages();
                        },
                        child: Text('Upload Images'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          selectImages();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Text("Supported formats are jpg.png.gif\n"
                          "Each photo must not exceed 5mb",style: TextStyle(color: Colors.grey),)],
                    ),
                  ),
                ),
      Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                  hint: _RegiondropDownValue == null
                      ? Text('Region*')
                      : Text(
                    _RegiondropDownValue!,
                    style: TextStyle(color: Colors.blue),
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: [
                    'Greater Accra',
                    'Northern Region',
                    'Ashanti Region ',
                    'Western Region',
                    'Volta Region',
                    'Eastern Region',
                    'Upper West Region',
                    'Upper East Region',
                    'Central Region',


                  ].map(
                        (Regionval) {
                      return DropdownMenuItem<String>(
                        value: Regionval,
                        child: Text(Regionval),
                      );
                    },
                  ).toList(),
                  onChanged: (Regionval) {
                    setState(
                          () {
                        _RegiondropDownValue = Regionval.toString();
                      },
                    );
                  },
                ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Make*',
                      border: OutlineInputBorder()),
                  validator: (val) => val!.isEmpty ? 'Enter your Make' : null,
                  onChanged: (val) {
                    setState(() => make = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Colour',
                      border: OutlineInputBorder()),
                  onChanged: (val) {
                    setState(() => Color = val);
                  },
                ),
              ),

                //condition
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  hint: _ConditiondropDownValue == null
                      ? Text('Condition*')
                      : Text(
                    _ConditiondropDownValue!,
                    style: TextStyle(color: Colors.blue),
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: [
                    'Brand-New',
                    'Used',



                  ].map(
                        (Conditionval) {
                      return DropdownMenuItem<String>(
                        value: Conditionval,
                        child: Text(Conditionval),
                      );
                    },
                  ).toList(),
                  onChanged: (Conditionval) {
                    setState(
                          () {
                        _ConditiondropDownValue = Conditionval.toString();
                      },
                    );
                  },
                ),
              ),

              //transmission
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  hint: _TransmissiondropDownValue == null
                      ? Text('Transmission*')
                      : Text(
                    _TransmissiondropDownValue!,
                    style: TextStyle(color: Colors.blue),
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: [
                    'AMT',
                    'Automatic',
                    'CVT',
                    'Manual'



                  ].map(
                        (Transmissionval) {
                      return DropdownMenuItem<String>(
                        value: Transmissionval,
                        child: Text(Transmissionval),
                      );
                    },
                  ).toList(),
                  onChanged: (Transmissionval) {
                    setState(
                          () {
                        _TransmissiondropDownValue = Transmissionval.toString();
                      },
                    );
                  },
                ),
              ),


              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Mileage',
                      border: OutlineInputBorder()),
                  validator: (val) => val!.isEmpty ? 'Enter your Mileage' : null,
                  onChanged: (val) {
                    setState(() => Milleage = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'VIN',
                      border: OutlineInputBorder()),
                  validator: (val) => val!.isEmpty ? 'Enter your VIN' : null,
                  onChanged: (val) {
                    setState(() => VIN = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              FirebaseAnimatedList(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Name",
                        border: OutlineInputBorder()),
                    validator: (val) => val!.isEmpty ? 'Enter your Name' : null,
                    onChanged: (val) {
                      setState(() => Name = val );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Price',
                      border: OutlineInputBorder()),
                  validator: (val) => val!.isEmpty ? 'Enter your Price' : null,
                  onChanged: (val) {
                    setState(() => Price = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Description',
                      border: OutlineInputBorder()),
                  validator: (val) => val!.isEmpty ? 'Enter your Description' : null,
                  onChanged: (val) {
                    setState(() => Description = val);
                  },
                ),
              ),
              RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    AddVehiclestofirestore(context);

                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
        ),
      ),
    ),

              ],
            ),
          ),
        ));
  }
  Future<void>AddVehiclestofirestore(BuildContext context)async{
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('NewVehicles')
          .doc(make)
          .set({
        'Vehicle Category': _VehicledropDownValue,
        'Region': _RegiondropDownValue,
        'Make': make,
        'Color': Color,
        'Condition':_ConditiondropDownValue,
        'Transmission':_TransmissiondropDownValue,
        'Mileage': Milleage,
        'VIN': VIN,
        'Name': Name,
        'Price': Price,
        'Description': Description,


      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return SignInScreen();
      //   }),
      //);

    }
  }
}
