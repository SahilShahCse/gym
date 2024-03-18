import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/pages/admin/homePage.dart';
import 'package:gym/pages/trainer/trainer_home_page.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/MemberModel.dart';
import 'pages/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xffededed), // Change the status bar color to white
      statusBarIconBrightness: Brightness.dark, // Use dark icons for status bar
      systemNavigationBarColor: Color(0xffededed), // Change the navigation bar color to white
      systemNavigationBarIconBrightness: Brightness.dark, // Use dark icons for navigation bar
    ),
  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemberProvider()),
        ChangeNotifierProvider(create: (context) => TrainerProvider()),
        ChangeNotifierProvider(create: (context) => OwnerProvider()),
      ],
      child: MaterialApp(
        title: 'Your App Title',
        theme: ThemeData(
          // Your app theme configuration
        ),
        home: TrainerHomePage(),
      ),
    ),
  );
}
