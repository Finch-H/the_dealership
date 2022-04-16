import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:the_dealership/allUsers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:the_dealership/assistants/progressdialog.dart';


class addvehicle extends StatefulWidget {
  const addvehicle({Key? key}) : super(key: key);
  static String idScreen = 'addVehicle';

  @override
  _addvehicleState createState() => _addvehicleState();
}


final ImagePicker _picker = ImagePicker();
File? _photo;
class _addvehicleState extends State<addvehicle> {
  User? user = FirebaseAuth.instance.currentUser;

  String get name => user!.displayName.toString();

  String? get email => user!.email.toString();

  String? _VehicledropDownValue;
  String? _RegiondropDownValue;
  String? _ConditiondropDownValue;
  String? _TransmissiondropDownValue;


  bool uploading = false;
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  List<File> _image = [];
  final picker = ImagePicker();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;
  String make = '';
  String model='';
  String Color = '';
  String Milleage = '';
  String VIN = '';
  String Description = '';
  String Price = '';
  String Name = '';
  String carClass = '';
  String carPower = '';
  String Seater = '';
  String Airbags = '';

  late List<Clients> Client;
  Clients? client;
  late DatabaseReference clientdb;

  @override
  void initState() {
    super.initState();
    Client = [];
    // user = users("","", "") ;
    final FirebaseDatabase database = FirebaseDatabase.instance;
    clientdb = database.reference().child('Ride Requests');
    clientdb.onChildAdded.listen(_onEntryAdded);
    clientdb.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(dynamic event) {
    setState(() {
      Client.add(Clients.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(dynamic event) {
    var old = Client.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      Client[Client.indexOf(old)] = Clients.fromSnapshot(event.snapshot);
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
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    String userId = firebaseUser.uid.toString();
    DatabaseReference userRef = FirebaseDatabase.instance
        .reference()
        .child("Clients")
        .child(userId)
        .child("name");

    DatabaseReference name = userRef;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Add to the Fleet or Rental'),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(


          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 30, right: 30),
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
                  height: 250,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: GridView.builder(
                        itemCount: _image.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                            child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                !uploading ? chooseImage() : null),
                          )
                              : Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image[index - 1]),
                                    fit: BoxFit.cover)),
                          );
                        }),
                  ),
                ),

               //multple Images
                // SizedBox(
                //   height: 70,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: GridView.builder(
                //             itemCount: imageFileList!.length,
                //             gridDelegate:
                //                 SliverGridDelegateWithFixedCrossAxisCount(
                //                     crossAxisCount: 3),
                //             itemBuilder: (BuildContext context, int index) {
                //               return Image.file(
                //                 File(imageFileList![index].path),
                //                 fit: BoxFit.cover,
                //               );
                //             }),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       ElevatedButton(
                //
                //         onPressed: () {
                //           selectImages();
                //         },
                //         child: Text('Upload Images'),
                //           style: ElevatedButton.styleFrom(primary:Colors.black),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             selectImages();
                //           },
                //           child: Text('Delete'),
                //           style: ElevatedButton.styleFrom(primary:Colors.black),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Upload at least 5 pictures\n"
                          "Supported formats are jpg.png.gif\n"
                          "Each photo must not exceed 5mb",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        //Region
                        SizedBox(height: 10.0),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 15, right: 15),
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

                        //Make
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Make*',
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your Make' : null,
                            onChanged: (val) {
                              setState(() => make = val);
                            },
                          ),
                        ),


                        //Model
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Model*',
                                border: OutlineInputBorder()),
                            validator: (val) =>
                            val!.isEmpty ? 'Enter your Model' : null,
                            onChanged: (val) {
                              setState(() => model = val);
                            },
                          ),
                        ),

                        //Seater
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Seater(1-5)',
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter Car Seater' : null,
                            onChanged: (val) {
                              setState(() => Seater = val);
                            },
                          ),
                        ),

                        //CarClass
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Class(economy,sport,etc)',
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter Car Class' : null,
                            onChanged: (val) {
                              setState(() => carClass = val);
                            },
                          ),
                        ),

                        //Car Color
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Colour',
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() => Color = val);
                            },
                          ),
                        ),

                        //condition
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 15, right: 15),
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
                                  _ConditiondropDownValue =
                                      Conditionval.toString();
                                },
                              );
                            },
                          ),
                        ),

                        //transmission
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 15, right: 15),
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
                            items: ['AMT', 'Automatic', 'CVT', 'Manual'].map(
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
                                  _TransmissiondropDownValue =
                                      Transmissionval.toString();
                                },
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Mileage',
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your Mileage' : null,
                            onChanged: (val) {
                              setState(() => Milleage = val);
                            },
                          ),
                        ),

                        //VIN
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'VIN', border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your VIN' : null,
                            onChanged: (val) {
                              setState(() => VIN = val);
                            },
                          ),
                        ),

                        //CarPower
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'CarPower', border: OutlineInputBorder()),
                            validator: (val) =>
                            val!.isEmpty ? 'Enter your VIN' : null,
                            onChanged: (val) {
                              setState(() => carPower = val);
                            },
                          ),
                        ),

                        //Airbags
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'No. Of Airbags', border: OutlineInputBorder()),
                            validator: (val) =>
                            val!.isEmpty ? 'Enter your VIN' : null,
                            onChanged: (val) {
                              setState(() => Airbags = val);
                            },
                          ),
                        ),

                        //Name
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: ("Name"),
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your Name' : null,
                            onChanged: (val) {
                              setState(() => Name = val);
                            },
                          ),
                        ),

                        //price
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Price',
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your Price' : null,
                            onChanged: (val) {
                              setState(() => Price = val);
                            },
                          ),
                        ),

                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Description',
                                border: OutlineInputBorder()),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your Description' : null,
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




                                  Future.wait([AddVehiclestofirestore(context),
                                    uploadFile(),]);





                            }),
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

  Future<void> AddVehiclestofirestore(BuildContext context) async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Adding,Please wait.....",);

        }


    );




    User? user = await FirebaseAuth.instance.currentUser;
    if (_VehicledropDownValue  != 'Rental') {
      await FirebaseFirestore.instance.collection('Fleets').doc(make+model).set({
        'Vehicle Category': _VehicledropDownValue,
        'Region': _RegiondropDownValue,
        'Make': make,
        'Model': model,
        'Color': Color,
        'Condition': _ConditiondropDownValue,
        'Transmission': _TransmissiondropDownValue,
        'Mileage': Milleage,
        'VIN': VIN,
        'Name': Name,
        'Price': Price,
        'Description': Description,
        'CarPower':carPower,
        'CarClass':carClass,
        'CarSeater':Seater,
        'CarAirbag':Airbags,
        //'ImageList':imageFileList,

      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return SignInScreen();
      //   }),
      //);

    }
    else if(_VehicledropDownValue !='Fleet'){

      await FirebaseFirestore.instance.collection('Rental').doc(make+model).set({
        'Vehicle Category': _VehicledropDownValue,
        'Region': _RegiondropDownValue,
        'Make': make,
        'Model': model,
        'Color': Color,
        'Condition': _ConditiondropDownValue,
        'Transmission': _TransmissiondropDownValue,
        'Mileage': Milleage,
        'VIN': VIN,
        'Name': Name,
        'Price': Price,
        'Description': Description,
        'CarPower':carPower,
        'CarClass':carClass,
        'CarSeater':Seater,
        'CarAirbag':Airbags,


      });
      displayToast("Congratulation, your vehicle has been added", context);
      Navigator.pop(context);
      Navigator.pop(context);

    }
  }
  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }



  Future uploadFile() async {



    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$make$model/${basename(img.path)}');
      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          FirebaseFirestore.instance
              .collection("images").doc(make).set({'url': value,"name": make});
          i++;
        });
      });
    }

  }

  displayToast(String message,BuildContext context)
  {
    Fluttertoast.showToast(msg: message);

  }



}
