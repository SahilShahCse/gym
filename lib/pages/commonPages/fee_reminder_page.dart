import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/MemberModel.dart';
import '../../providers/MemberProvider.dart';
import 'user_detail_page.dart';

class FeeReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expiring in 5 Days'),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<MemberProvider>(
        builder: (context, memberProvider, _) {
          List<Member> allMembers = memberProvider.members;
          List<Member> expiringMembers = _filterExpiringMembers(allMembers);

          return expiringMembers.isEmpty
              ? Center(
            child: Text('No membership due within 5 days.'),
          )
              : _buildExpiringMembersList(expiringMembers);
        },
      ),
    );
  }

  List<Member> _filterExpiringMembers(List<Member> allMembers) {
    return allMembers.where((member) {
      if (member.membershipExpiryDate != null) {
        int daysDifference =
            member.membershipExpiryDate!.difference(DateTime.now()).inDays;
        return daysDifference <= 5 && daysDifference >= 0;
      }
      return false;
    }).toList();
  }

  Widget _buildExpiringMembersList(List<Member> expiringMembers) {
    return ListView.builder(
      itemCount: expiringMembers.length,
      itemBuilder: (context, index) {
        final member = expiringMembers[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    UserDetailPage(member: member),
              ),
            );
          },
          title: Text(member.fullName),
          subtitle: Text(
              'Membership Expiry Date: ${member.membershipExpiryDate!.toLocal().toString().split(' ')[0]}\nContact Number: ${member.phoneNumber}'),
        );
      },
    );
  }
}
