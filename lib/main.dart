import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_dealership/Pages/addvehicle.dart';
import 'package:the_dealership/Pages/forgotpassword.dart';
import 'package:the_dealership/Pages/login.dart';
import 'package:the_dealership/Pages/homepage.dart';
import 'package:the_dealership/Pages/testimageupload.dart';
import 'package:the_dealership/onboarding.dart';
import 'package:the_dealership/Pages/signup.dart';
import 'splash.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Pages/fleet.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());

  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
  } else {
    Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBEdrfRGqF-spsLPyLrNJtrHJsLnu6lLVs",
        appId: "1:829773441286:web:3b62d908c935717a49d687",
        messagingSenderId: "829773441286",
        projectId: "thedealership-a0ac9",
      ),
    );
  }
  runApp(App());

  //
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp(const App());
}

DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // defaultTransition: Transition.rightToLeft,
      // transitionDuration: Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      title: 'Car Rental App',
      home: SplashScreen(),
      //
      //initialRoute:  SignInScreen.idScreen,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? SignInScreen.idScreen
          : homepage.idScreen,
      routes: {
        SignUP.idScreen: (context) => SignUP(),
        SignInScreen.idScreen: (context) => SignInScreen(),
        homepage.idScreen: (context) => homepage(),
        OnBoardingPage.idScreen: (context) => OnBoardingPage(),
        ForgotPassword.id: (context) => ForgotPassword(),
        addvehicle.idScreen: (context) => addvehicle(),
        //testimage.idScreen:(context)=>testimage(),
      },
    );
    throw UnimplementedError();
  }
}

