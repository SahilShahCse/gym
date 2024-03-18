import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/MemberModel.dart';
import '../../../providers/MemberProvider.dart';
import '../pages/commonPages/user_detail_page.dart';

class PersonalTrainingList extends StatelessWidget {
  final List<Member> trainingMembers;

  PersonalTrainingList(this.trainingMembers);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: trainingMembers.map((member) {
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
      }).toList(),
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
