import 'package:flutter/material.dart';
import 'package:gym/pages/userInfoAdmin/user_detail_page.dart';
import '../../models/MemberModel.dart';

class ManageMembersPage extends StatefulWidget {
  @override
  _ManageMembersPageState createState() => _ManageMembersPageState();
}

class _ManageMembersPageState extends State<ManageMembersPage> {
  
  final List<Member> _members = [
    Member(
      id: '1',
      fullName: 'John Doe',
      email: 'john@example.com',
      password: 'password1',
      gymCode: 'Gym1',
      phoneNumber: '1234567890',
      address: '123 Street, City',
      isActive: true,
      isPaid: true,
      membershipExpiryDate: DateTime.now().add(Duration(days: 5)), // Membership expires in 5 days
    ),
    Member(
      id: '2',
      fullName: 'Jane Smith',
      email: 'jane@example.com',
      password: 'password2',
      gymCode: 'Gym2',
      phoneNumber: '9876543210',
      address: '456 Road, Town',
      isActive: false,
      isPaid: true,
      membershipExpiryDate: DateTime.now().add(Duration(days: 7)), // Membership expires in 7 days
    ),
    Member(
      id: '3',
      fullName: 'Alice Johnson',
      email: 'alice@example.com',
      password: 'password3',
      gymCode: 'Gym3',
      phoneNumber: '5551234567',
      address: '789 Avenue, Village',
      isActive: true,
      isPaid: false,
      membershipExpiryDate: DateTime.now().subtract(Duration(days: 2)), // Membership expired 2 days ago
    ),
  ];

  @override
  Widget build(BuildContext context) {
    
    // Filter members whose membership is expiring in 5 days or less
    List<Member> expiringMembers = _members.where((member) {

      if(member.membershipExpiryDate != null){

        // Calculate the difference in days between today and the membership expiry date
        int daysDifference = member.membershipExpiryDate!.difference(DateTime.now()).inDays;

        // Return true if membership expires in 5 days or less
        return daysDifference <= 5 && daysDifference >= 0;
      }

      return false;

    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Expiring in 5 Days'),
        scrolledUnderElevation: 0,
      ),
      body: ListView.builder(
        itemCount: expiringMembers.length,
        itemBuilder: (context, index) {
          final member = expiringMembers[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => UserDetailPage(member: member),
                ),
              );
            },
            title: Text(member.fullName),
            subtitle: Text('Membership Expiry Date: ${member.membershipExpiryDate!.toLocal().toString().split(' ')[0]}\nContact Number: ${member.phoneNumber}'),
          );
        },
      ),
    );
  }
}
