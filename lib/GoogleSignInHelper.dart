import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/pages/loginPage.dart';
import 'package:gym/pages/owner/home_page.dart';
import 'package:gym/pages/select_role_page.dart';
import 'package:gym/pages/trainer/trainer_home_page.dart';
import 'package:gym/pages/user/client_home_page.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';
import '../models/MemberModel.dart';
import '../models/OwnerModel.dart';
import '../models/TrainerModel.dart';

class GoogleSignInHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> signIn(BuildContext context) async {

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Successful sign-in with Google
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credentials
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // Check if the user exists in any collection (members, trainers, owners)
        var userDocSnapshot = await FirebaseFirestore.instance
            .collection('members')
            .doc(googleSignInAccount.id)
            .get();
        if (!userDocSnapshot.exists) {
          userDocSnapshot = await FirebaseFirestore.instance
              .collection('trainers')
              .doc(googleSignInAccount.id)
              .get();
        }
        if (!userDocSnapshot.exists) {
          userDocSnapshot = await FirebaseFirestore.instance
              .collection('owners')
              .doc(googleSignInAccount.id)
              .get();
        }
        if (userDocSnapshot.exists) {
          // User exists, determine their role
          final userData = userDocSnapshot.data()!;
          final String? role = userData['role'];

          if (role == null) {
            print('Role not found');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectRolePage(googleSignInAccount)),
                  (route) => false,
            );
          } else {
            // Role found, navigate to respective page
            switch (role) {
              case 'members':
                Provider.of<MemberProvider>(context, listen: false)
                    .setMember(Member.fromMap(userData));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ClientHomePage()),
                      (route) => false,
                );
                break;
              case 'trainers':
                Provider.of<TrainerProvider>(context, listen: false)
                    .setTrainer(Trainer.fromMap(userData));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => TrainerHomePage()),
                      (route) => false,
                );
                break;
              case 'owners':
                Provider.of<OwnerProvider>(context, listen: false)
                    .setOwner(Owner.fromMap(userData));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                      (route) => false,
                );
                break;
              default:
              // Invalid role, navigate to set details page
                print('Default case');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SelectRolePage(googleSignInAccount)),
                      (route) => false,
                );
                break;
            }
          }
        } else {
          // User does not exist in any collection, navigate to set details page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SelectRolePage(googleSignInAccount)),
                (route) => false,
          );
        }
      }
    } catch (error) {
      // Handle sign-in errors
      print('Error signing in with Google: $error');
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      // Navigate to your sign-in page or any other page as needed
      Provider.of<OwnerProvider>(context,listen: false).setOwner(Owner(id: '', name: '', age: 0, gender: ''));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
      );
    } catch (error) {
      // Handle sign-out errors
      print('Error signing out with Google: $error');
    }
  }

}
