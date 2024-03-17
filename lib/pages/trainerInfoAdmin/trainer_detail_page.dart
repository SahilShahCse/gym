import 'package:flutter/material.dart';

import '../../models/MemberModel.dart';
import '../../models/TrainerModel.dart';
import '../userInfoAdmin/user_detail_page.dart';

class TrainerDetailPage extends StatefulWidget {
  final Trainer trainer;
  const TrainerDetailPage({super.key, required this.trainer});

  @override
  State<TrainerDetailPage> createState() => _TrainerDetailPageState();
}

class _TrainerDetailPageState extends State<TrainerDetailPage> {
  List<Member> _trainingMembers = [
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
    ),
  ];

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Shift'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                child: Text('Morning'),
                onPressed: () {
                  widget.trainer.shift = 'Morning';
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              TextButton(
                child: Text('Evening'),
                onPressed: () {
                  widget.trainer.shift = 'Evening';
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              TextButton(
                child: Text('All Day'),
                onPressed: () {
                  widget.trainer.shift = 'All Day';
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.trainer.name}'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Trainer Detail\'s',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Trainer ID:'),
                    subtitle: Text('${widget.trainer.id}'),
                  ),
                  ListTile(
                    title: Text('Address:'),
                    subtitle: Text('${widget.trainer.address}'),
                  ),
                  ListTile(
                    title: Text('Email:'),
                    subtitle: Text('${widget.trainer.emailId}'),
                  ),
                  ListTile(
                    title: Text('Contact:'),
                    subtitle: Text('${widget.trainer.contact}'),
                  ),
                  ListTile(
                    title: Text('Salary:'),
                    subtitle: Text('${widget.trainer.salary}'),
                  ),
                  ListTile(
                    onTap: _showDialog,
                    title: Text('Shift:'),
                    subtitle: Text('${widget.trainer.shift}'),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Personal Training List',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            for (var member in _trainingMembers)
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => UserDetailPage(
                        member: member,
                      ),
                    ),
                  );
                },
                title: Text(member.fullName),
                trailing: Switch(
                  value: member.isPaid,
                  onChanged: (value) {
                    setState(() {
                      member.isPaid = value;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
