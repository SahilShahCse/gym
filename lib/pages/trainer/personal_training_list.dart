import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/MemberModel.dart';
import '../../../providers/MemberProvider.dart';
import '../commonPages/user_detail_page.dart';

class PersonalTrainingPage extends StatefulWidget {
  @override
  State<PersonalTrainingPage> createState() => _PersonalTrainingPageState();
}

class _PersonalTrainingPageState extends State<PersonalTrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Personal Training'),
      ),
      body: SafeArea(
        child: Consumer<MemberProvider>(
          builder: (context, memberProvider, _) {
            final trainingMembers = memberProvider.getMembersByTrainerId('6ZkyLrcpmVjxht6zaSwD');

            return ListView.builder(
              itemCount: trainingMembers.length,
              itemBuilder: (context, index) {
                final member = trainingMembers[index];
                return ListTile(
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
                  trailing: _buildPaymentSwitch(context, member),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPaymentSwitch(BuildContext context, Member member) {
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    return Switch(
      value: member.isPaid,
      onChanged: (value) {
        memberProvider.updateMemberPaymentStatus(member.id, value);
      },
    );
  }
}
