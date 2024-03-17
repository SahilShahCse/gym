import 'package:flutter/material.dart';
import 'package:gym/brains/bmi_brain.dart';
import 'package:gym/pages/userInfoAdmin/diet_page.dart';
import 'package:gym/pages/userInfoAdmin/workout_page.dart';

import '../../components/circularProgressIndicatorWithText.dart';
import '../../models/MemberModel.dart';

class UserDetailPage extends StatefulWidget {
  final Member member;

  const UserDetailPage({super.key, required this.member});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.member.fullName}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            getBasicInfo(),
            SizedBox(height: 20),
            getSubscriptionInfo(),
            SizedBox(height: 20),
            getBmi(),
            SizedBox(height: 20),
            getMoreDetails(context),
          ],
        ),
      ),
    );
  }

  Widget getBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'User Detail\'s'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              ListTile(
                title: Text('Contact:'),
                subtitle: Text('${widget.member.phoneNumber}'),
              ),
              ListTile(
                title: Text('Active:'),
                subtitle: Text('${widget.member.isActive ? 'Yes' : 'No'}'),
              ),
              ListTile(
                title: Text('Membership Ends on:'),
                subtitle: Text(
                    '${DateTime.now().toLocal().toIso8601String().substring(0, 10)}'),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget getSubscriptionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'Subscription Charges'),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0 , vertical: 15),
          child: Row(
            children: [
              Switch(
                value: widget.member.isPaid,
                onChanged: (value) {
                  setState(() {
                    widget.member.isPaid = value;
                  });
                },
              ),
              SizedBox(width: 5),
              Text(
                widget.member.isPaid ? 'Paid' : 'Not Paid',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget getBmi() {
    BmiCalculate bmi = BmiCalculate(height: 162, weight: 60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'Body Mass Index'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0 , vertical: 35),
          child: Row(
            children: [
              CircularProgressWithText(
                bmi.result() * 100 / 40,
                (bmi.result()).toString().substring(0, 4),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bmi.getText(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(bmi.getAdvise()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  Column getMoreDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'More Detail\'s'),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => WorkoutPage()));
                },
                title: Text('Workout'),
                leading: Icon(Icons.fitness_center),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DietPage()));
                },
                title: Text('Diet'),
                leading: Icon(Icons.brunch_dining),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildHeadings({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        '${title}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
