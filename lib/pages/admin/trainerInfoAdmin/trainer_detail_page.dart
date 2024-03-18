import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/personal_training_list.dart';
import '../../../models/MemberModel.dart';
import '../../../models/TrainerModel.dart';
import '../../../providers/MemberProvider.dart';
import '../../commonPages/user_detail_page.dart';

class AdminTrainerDetailPage extends StatelessWidget {
  final Trainer trainer;

  AdminTrainerDetailPage({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${trainer.name}'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Trainer Details'),
            _buildTrainerDetails(trainer),
            _buildSectionTitle('Personal Training List'),
            PersonalTrainingList(
              Provider.of<MemberProvider>(context).getMembersByTrainerId(trainer.id!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildTrainerDetails(Trainer trainer) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          _buildDetailTile('Trainer ID:', trainer.id),
          _buildDetailTile('Address:', trainer.address),
          _buildDetailTile('Email:', trainer.emailId),
          _buildDetailTile('Contact:', trainer.contact),
          _buildDetailTile('Salary:', '${trainer.salary}'),
          _buildDetailTile('Shift:', trainer.shift),
        ],
      ),
    );
  }

  Widget _buildDetailTile(String title, String? subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle ?? ''),
    );
  }

  Widget _buildTrainingMembersList(BuildContext context) {
    return Consumer<MemberProvider>(
      builder: (context, memberProvider, _) {
        List<Member> trainingMembers = memberProvider.getMembersByTrainerId(trainer.id!);
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
              trailing: _buildPaymentSwitch(member, memberProvider),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPaymentSwitch(Member member, MemberProvider memberProvider) {
    return Switch(
      value: member.isPaid,
      onChanged: (value) {
        memberProvider.updateMemberPaymentStatus(member.id, value);
      },
    );
  }
}
