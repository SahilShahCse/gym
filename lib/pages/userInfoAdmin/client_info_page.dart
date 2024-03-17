import 'package:flutter/material.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:provider/provider.dart';
import 'package:gym/providers/MemberProvider.dart'; // Import the MemberProvider
import 'package:gym/pages/userInfoAdmin/user_detail_page.dart';
import '../../models/MemberModel.dart';

class ClientsListPage extends StatefulWidget {

  @override
  State<ClientsListPage> createState() => _ClientsListPageState();
}

class _ClientsListPageState extends State<ClientsListPage> {
  void initState() {
    super.initState();
    // Fetch members by gym ID when the page is initialized
    Provider.of<MemberProvider>(context, listen: false)
        .fetchMembersByGymCode(Provider.of<OwnerProvider>(context).owner.gymCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
      ),
      body: Consumer<MemberProvider>(
        builder: (context, memberProvider, _) {

          // Access the list of members from the provider
          List<Member> members = memberProvider.members;

          return ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
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
                trailing: Switch(
                  value: member.isPaid,
                  onChanged: (value) {
                    // Update the member's payment status using the provider
                    memberProvider.updateMemberPaymentStatus(member.id, value);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
