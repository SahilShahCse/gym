import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/owner/MemberDetailScreen.dart';
import 'package:gym/widgets/custom_list_tile.dart';

import '../models/MemberModel.dart';

class CustomMemberList extends StatefulWidget {
  final List<Member> members;
  const CustomMemberList({super.key, required this.members});

  @override
  State<CustomMemberList> createState() => _CustomMemberListState();
}

class _CustomMemberListState extends State<CustomMemberList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.members.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomListTile(
          title: '${widget.members[index].name}',
          subtitle: '${widget.members[index].phoneNumber}',
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MemberDetailPage(member: widget.members[index])));
          },
        );
      },
    );
  }
}
