import 'package:flutter/material.dart';
import 'package:gym/pages/commonPages/diet_page.dart';
import 'package:gym/pages/commonPages/workout_page.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:provider/provider.dart';

import '../../components/circularProgressIndicatorWithText.dart';
import '../../models/MemberModel.dart';
import '../../brains/bmi_brain.dart';

class UserDetailPage extends StatefulWidget {
  final Member member;

  const UserDetailPage({Key? key, required this.member}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  late Member _memberData;

  @override
  void initState() {
    super.initState();
    _memberData = Provider.of<MemberProvider>(context, listen: false)
        .getMemberById(widget.member.id)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_memberData.fullName}'),
      ),
      body: Consumer<MemberProvider>(
        builder: (context, memberProvider, _) {
          _memberData = memberProvider.getMemberById(widget.member.id)!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                _buildBasicInfo(),
                SizedBox(height: 20),
                _buildSubscriptionInfo(),
                SizedBox(height: 20),
                _buildBmi(),
                SizedBox(height: 20),
                _buildMoreDetails(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'User Details'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBasicInfoListTile('Contact:', '${_memberData.phoneNumber}'),
              _buildBasicInfoListTile('Active:', '${_memberData.isActive ? 'Yes' : 'No'}'),
              _buildBasicInfoListTile('Membership Ends on:', '${DateTime.now().toLocal().toIso8601String().substring(0, 10)}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'Subscription Charges'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Row(
            children: [
              _buildSubscriptionSwitch(),
              SizedBox(width: 5),
              _buildSubscriptionStatusText(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBmi() {
    BmiCalculate bmi = BmiCalculate(height: 162, weight: 60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'Body Mass Index'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 35),
          child: Row(
            children: [
              CircularProgressWithText(
                bmi.result() * 100 / 40,
                (bmi.result()).toString().substring(0, 4),
              ),
              SizedBox(width: 20),
              _buildBmiDetails(bmi),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoreDetails(BuildContext context) {
    print(_memberData.diet);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadings(title: 'More Details'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              _buildMoreDetailsListTile(context, 'Workout', Icons.fitness_center, WorkoutPage(member: _memberData,)),
              _buildMoreDetailsListTile(context, 'Diet', Icons.brunch_dining, DietPage(member: _memberData,)),
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
        '$title',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildBasicInfoListTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildSubscriptionSwitch() {
    return Switch(
      value: _memberData.isPaid,
      onChanged: (value) {
        Provider.of<MemberProvider>(context, listen: false)
            .updateMemberPaymentStatus(_memberData.id, value);
      },
    );
  }

  Widget _buildSubscriptionStatusText() {
    return Text(
      _memberData.isPaid ? 'Paid' : 'Not Paid',
      style: TextStyle(fontWeight: FontWeight.w500),
    );
  }

  Widget _buildBmiDetails(BmiCalculate bmi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bmi.getText(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(bmi.getAdvise()),
      ],
    );
  }

  Widget _buildMoreDetailsListTile(BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
      },
      title: Text(title),
      leading: Icon(icon),
    );
  }
}
