import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/firebase_options.dart';
import 'package:gym/pages/loginPage.dart';
import 'package:gym/pages/user/client_home_page.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xffededed),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xffededed),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemberProvider()),
        ChangeNotifierProvider(create: (context) => OwnerProvider()),
        ChangeNotifierProvider(create: (context) => TrainerProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym',
      theme: ThemeData(
        // Your app theme configuration
      ),
      home: SplashScreen(), // Initial screen
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch data or perform initialization tasks here

    // Simulate data loading with Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      // Check if the user is signed in
      // For demonstration purposes, assume the user is not signed in
      bool isUserSignedIn = false;

      // Navigate based on user authentication state
      if (isUserSignedIn) {
        // If user is signed in, navigate to home page
        // Replace 'ClientHomePage' with your home page widget
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ClientHomePage()),
        );
      } else {
        // If user is not signed in, navigate to login/signup page
        // Replace 'LoginPage' with your login/signup page widget
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });

    // Display a loading indicator while checking authentication state
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
