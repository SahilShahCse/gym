import 'package:flutter/material.dart';
import 'package:gym/GoogleSignInHelper.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final owner = Provider.of<OwnerProvider>(context).owner;

    return Scaffold(
      appBar:  AppBar(
        title: Text('P R O F I L E', style: TextStyle(color: Color(0xff720455))),
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              _showLogoutConfirmation(context);
            },
            child: Icon(Icons.logout_rounded , color: Color(0xff720455),),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          children: [
            CustomListTile(
              title: 'Name',
              subtitle: owner.name,
            ),
            CustomListTile(
              title: 'Email',
              subtitle: owner.email ?? 'Not available',
            ),
            CustomListTile(
              title: 'Gym Code',
              subtitle: owner.gymCode ?? 'Not available',
            ),
            CustomListTile(
              title: 'Gym Name',
              subtitle: owner.gymName ?? 'Not available',
            ),
            CustomListTile(
              title: 'Gym Location',
              subtitle: owner.gymLocation ?? 'Not available',
            ),
            CustomListTile(
              title: 'Age',
              subtitle: owner.age.toString(),
            ),
            CustomListTile(
              title: 'Gender',
              subtitle: owner.gender,
            ),
            CustomListTile(
              title: 'Phone Number',
              subtitle: owner.phoneNumber ?? 'Not available',
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to logout?'),
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
}
