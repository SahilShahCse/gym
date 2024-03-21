import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/select_role_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym/pages/trainer/trainer_home_page.dart';
import 'package:gym/pages/user/client_home_page.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';

import '../models/MemberModel.dart';
import '../models/OwnerModel.dart';
import '../models/TrainerModel.dart';
import 'owner/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _fetchMembers(BuildContext context) {
    // Fetch members using Provider
    Provider.of<MemberProvider>(context, listen: false).fetchMembersByGymCode(
        Provider.of<OwnerProvider>(context).owner.gymCode ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _signInWithGoogle(context);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.g_mobiledata),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sign in with Google'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        print('Google account found ${googleSignInAccount.id}');

        // Successful sign-in with Google
        final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credentials
        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

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
            print('role not found');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectRolePage(googleSignInAccount)),
            );
          } else {
            // Role found, navigate to respective page
            switch (role) {
              case 'members':
                Provider.of<MemberProvider>(context, listen: false)
                    .setMember(Member.fromMap(userData));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientHomePage()),
                );
                break;
              case 'trainers':
                Provider.of<TrainerProvider>(context, listen: false)
                    .setTrainer(Trainer.fromMap(userData));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrainerHomePage()),
                );
                break;
              case 'owners':
                Provider.of<OwnerProvider>(context, listen: false)
                    .setOwner(Owner.fromMap(userData));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
                break;
              default:
              // Invalid role, navigate to set details page
                print('Default called');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SelectRolePage(googleSignInAccount)),
                );
                break;
            }
          }
        } else {
          // User does not exist in any collection, navigate to set details page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectRolePage(googleSignInAccount)),
          );
        }
      }
    } catch (error) {
      // Handle sign-in errors
      print('Error signing in with Google: $error');
    }
  }

}
