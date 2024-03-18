import 'package:flutter/material.dart';
import 'package:gym/components/custom_list_tile.dart';
import 'package:gym/pages/commonPages/user_detail_page.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:provider/provider.dart';
import 'package:gym/providers/MemberProvider.dart';
import '../../models/MemberModel.dart';

class ClientPage extends StatefulWidget {
  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    _fetchMembers(); // Fetch members when the page builds
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Clients'),
      ),
      body: _buildMemberList(), // Build the list of members
    );
  }

  void _fetchMembers() {
    // Fetch members using Provider
    Provider.of<MemberProvider>(context, listen: false).fetchMembersByGymCode(
        Provider.of<OwnerProvider>(context).owner.gymCode);
  }

  Widget _buildMemberList() {
    return Consumer<MemberProvider>(
      builder: (context, memberProvider, _) {
        List<Member> members = memberProvider.members;
        return ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return _buildMemberTile(member);
          },
        );
      },
    );
  }

  Widget _buildMemberTile(Member member) {
    return CustomListTile(
      title: member.fullName,
      onTap: () {
        _navigateToUserDetailPage(member);
      },
      showToggle: true,
      toggleValue: member.isPaid,
      onToggle: (value){
        _updateMemberPaymentStatus(member, value);
      },
      subtitle: '${(member.trainerId!=null)? 'Trainer Assigned' : 'No Trainer Assigned'}',
    );
  }

  void _navigateToUserDetailPage(Member member) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => UserDetailPage(
          member: member,
        ),
      ),
    );
  }

  void _updateMemberPaymentStatus(Member member, bool value) {
    // Update the member's payment status using the provider
    Provider.of<MemberProvider>(context, listen: false)
        .updateMemberPaymentStatus(member.id, value);
  }
}
