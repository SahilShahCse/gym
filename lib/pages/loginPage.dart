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

import '../GoogleSignInHelper.dart';
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
                  GoogleSignInHelper.signIn(context);
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


}
