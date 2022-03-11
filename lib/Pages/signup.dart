

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_dealership/onboarding.dart';

import 'login.dart';
import '../assistants/progressdialog.dart';
import '../main.dart';

class SignUP extends StatelessWidget {
  static const String idScreen = "signUP";

  TextEditingController nameTextEditingController= TextEditingController();
  TextEditingController emailTextEditingController= TextEditingController();
  TextEditingController passwordTextEditingController= TextEditingController();
  TextEditingController phoneTextEditingController= TextEditingController();
  late String _email, _password, _fullName, _mobileNumber;
  User ?firebaseUser;
  User? currentfirebaseUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget _backButton() {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
              ),
              const Text('Back',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      );
    }

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(

        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: _backButton(),
            ),
            Text("DEALERSHIP",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 100,
              width: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/golf.png"),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),

                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("SIGN UP",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff070606),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                )),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.person,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff070606),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: nameTextEditingController,
                                  onChanged: (value) {
                                    _fullName = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Full Name",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.alternate_email,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff070606),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: emailTextEditingController,
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Email Address",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.phone,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff070606),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: phoneTextEditingController,
                                  onChanged: (value) {
                                    _mobileNumber = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Mobile Number",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.lock,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff070606),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: passwordTextEditingController,
                                    obscureText: true,
                                  onChanged: (value) {
                                    _password = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black, //icon bg color
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              // S
                              height: 50.0,
                              child: Center(
                                child: Text('Sign Up',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? const Color(0xff070606)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    )),
                              ),
                            ),
                          ),
                          onTap: ()  {
                            if (nameTextEditingController.text.length < 0) {
                              displayToast("Name must be atleast 3 characters.", context);
                            }
                            else if (!emailTextEditingController.text.contains("@")) {
                              displayToast("Email address is not Valid", context);
                            }

                            else if (phoneTextEditingController.text.isEmpty) {
                              displayToast("PhoneNumber are mandatory", context);
                            }
                            //
                            else if (passwordTextEditingController.text.length < 6) {
                              displayToast("Password must be atleast 6 Characters", context);
                            }
                            else  {
                              //registerNewUser(context);
                              Future.wait([registerNewUser(context),
                               registerinfirestore(context)]);

                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ),
                ),
            ]),
      ),

    );
  }

  Future<void>registerinfirestore(BuildContext context)async{
    User? user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_email)
          .set({
        'FullName': _fullName,
        'MobileNumber': _mobileNumber,
        'Email': _email,
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return SignInScreen();
      //   }),
      // );

    }
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> registerNewUser(BuildContext context)
  async {


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering,Please wait.....",);

        }


    );




    firebaseUser=(await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToast("Error"+errMsg.toString(), context);

    })).user;

    if (firebaseUser != null)// user created

        {
      //save use into to database


      Map userDataMap={
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),

      };
      clients.child(firebaseUser!.uid).set(userDataMap);
      // Admin.child(firebaseUser!.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;



      displayToast("Congratulation, your account has been created", context);


      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          OnBoardingPage()), (Route<dynamic> route) => false);

    }
    else
    {
      Navigator.pop(context);
      //error occured - display error
      displayToast("user has not been created", context);
    }
  }

  displayToast(String message,BuildContext context)
  {
    Fluttertoast.showToast(msg: message);

  }
}
