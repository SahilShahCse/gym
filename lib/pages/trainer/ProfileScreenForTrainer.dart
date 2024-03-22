import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';

import '../../GoogleSignInHelper.dart';
import '../../widgets/CustomList.dart';

class ProfileScreenForTrainer extends StatelessWidget {
  const ProfileScreenForTrainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trainer = Provider.of<TrainerProvider>(context).trainer;

    void _showLogoutConfirmation(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm...', style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600 ),),
          content: Text('Are you sure you want to Logout?' , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                GoogleSignInHelper.signOut(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('P R O F I L E' , style: TextStyle(color: Color(0xff720455)),),
        actions: [
          TextButton(
            onPressed: () {
              _showLogoutConfirmation(context);
            },
            child: Icon(Icons.logout_rounded , color: Color(0xff720455),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Personal Details:',style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 17 , color:  Color(0xff910A67)),),
            ),
            SizedBox(height: 16),

            CustomList(
              title: [
                'Name',
                'Email',
                'Phone Number',
                'Address',
                'Age',
                'Gender',
              ],
              subtitle: [
                trainer.name ?? 'Not available',
                trainer.emailId ?? 'Not available',
                trainer.phoneNumber ?? 'Not available',
                trainer.address ?? 'Not available',
                trainer.age != null ? trainer.age.toString() : 'Not available',
                trainer.gender ?? 'Not available',
              ],
              onTap: [],
            ),
            SizedBox(height: 16),
            Container(
              height: 0.5,
              width: double.maxFinite,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Gym Details:', style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 17 , color:  Color(0xff910A67))),
            ),
            SizedBox(height: 16),

            CustomList(
              title: [
                'Gym Code',
                'Is in Gym',
                'Can See Mobile Numbers',
                'Can Update Payment Status',
              ],
              subtitle: [
                trainer.gymCode ?? 'Not available',
                trainer.isInGym != null
                    ? (trainer.isInGym! ? 'Yes' : 'No')
                    : 'Not available',
                trainer.canSeeMobileNumbers != null
                    ? (trainer.canSeeMobileNumbers! ? 'Yes' : 'No')
                    : 'Not available',
                trainer.canUpdatePaymentStatus != null
                    ? (trainer.canUpdatePaymentStatus! ? 'Yes' : 'No')
                    : 'Not available',
              ],
              onTap: List.generate(12, (index) => null),
            ),
          ],
        ),
      ),
    );
  }
}
