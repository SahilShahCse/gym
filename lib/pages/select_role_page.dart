import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym/models/MemberModel.dart';
import 'package:gym/models/TrainerModel.dart';
import 'package:gym/pages/trainer/trainer_home_page.dart';
import 'package:gym/pages/user/client_home_page.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';
import '../models/OwnerModel.dart';
import '../providers/OwnerProvider.dart';
import 'owner/home_page.dart';

class SelectRolePage extends StatefulWidget {
  final GoogleSignInAccount googleSignInAccount;

  SelectRolePage(this.googleSignInAccount);

  @override
  _SelectRolePageState createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<SelectRolePage> {
  String? _selectedRole;
  String? _name;
  String? _gender;
  String? _contactNumber;
  String? _gymCode;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text field for name
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              // Text field for age
              TextField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _age = int.tryParse(value);
                  });
                },
              ),
              SizedBox(height: 20.0),

              //Text field For Contact Number
              TextField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _contactNumber = value;
                    print('value of contact no : ${value}');
                  });
                },
              ),
              SizedBox(height: 20.0),

              // Radio buttons for selecting gender
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text('Female'),
                      Radio<String>(
                        value: 'Other',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text('Other'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Radio buttons for selecting role
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Role:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'members',
                        groupValue: _selectedRole,
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                      ),
                      Text('Member'),
                      Radio<String>(
                        value: 'trainers',
                        groupValue: _selectedRole,
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                      ),
                      Text('Trainer'),
                      Radio<String>(
                        value: 'owners',
                        groupValue: _selectedRole,
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                      ),
                      Text('Gym Owner'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              (_selectedRole != 'owners')
                  ? TextField(
                      decoration: InputDecoration(labelText: 'Gym Code'),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          _gymCode = value;
                          print('value of contact no : ${value}');
                        });
                      },
                    )
                  : Center(child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text('Gym Code Will be assigned to u with along with joining gifts shortly...' , textAlign: TextAlign.center,),
                  ),),

              Spacer(),

              InkWell(
                onTap: _selectedRole != null &&
                        _name != null &&
                        _gender != null &&
                        _age != null
                    ? () async {
                        setUserAndNavigate(context, _selectedRole!);
                      }
                    : () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: Center(
                    child: Text('C O N T I N U E'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setUserAndNavigate(BuildContext context, String role) async {
    if (_selectedRole == null ||
        _contactNumber == null ||
        _name == null ||
        _age == null ||
        _gender == null) {
      return;
    }

    try {
      // Set user data in Firebase
      await FirebaseFirestore.instance
          .collection(role)
          .doc(widget.googleSignInAccount.id)
          .set({
        'id': widget.googleSignInAccount.id,
        'name': _name,
        'age': _age,
        'gender': _gender,
        'role': role,
        'phoneNumber' : _contactNumber,
        'gymCode' : _gymCode ?? '00000',
      });

      // Get the user model based on the role
      dynamic user;
      switch (role) {
        case 'members':
          user = Member(
            id: widget.googleSignInAccount.id,
            name: _name!,
            age: _age,
            gender: _gender,
            phoneNumber: _contactNumber,
            // Initialize other properties if needed
          );
          Provider.of<MemberProvider>(context, listen: false).setMember(user);
          break;
        case 'trainers':
          user = Trainer(
            id: widget.googleSignInAccount.id,
            name: _name,
            age: _age,
            gender: _gender,
            phoneNumber: _contactNumber,
            // Initialize other properties if needed
          );
          Provider.of<TrainerProvider>(context, listen: false).setTrainer(user);
          break;
        case 'owners':
          user = Owner(
            id: widget.googleSignInAccount.id,
            name: _name!,
            age: _age!,
            gender: _gender!,
            phoneNumber: _contactNumber,
            // Initialize other properties if needed
          );
          Provider.of<OwnerProvider>(context, listen: false).setOwner(user);
          break;
      }

      // Navigate to the appropriate home page
      switch (role) {
        case 'members':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ClientHomePage()));
          break;
        case 'trainers':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TrainerHomePage()));
          break;
        case 'owners':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminHomePage()));
          break;
      }
    } catch (error) {
      // Handle errors
      print('Error setting user data and navigating: $error');
    }
  }
}
