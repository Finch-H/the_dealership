import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  final _formKey = GlobalKey<FormState>();


  String error = '';
  bool loading = false;
  String name = '';
  String nickname = '';
  String city = '';

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
                  validator: (val) => val!.isEmpty ? 'Enter your name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
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
                    setState(() => nickname = val);
                  },
                ),
              ),

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
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'City',
                      border: OutlineInputBorder()),
                  validator: (val) => val!.isEmpty ? 'Enter your city' : null,
                  onChanged: (val) {
                    setState(() => city = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),

              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {

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
}
