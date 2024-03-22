import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/MemberDetailScreen.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';

import '../models/MemberModel.dart';
import '../models/TrainerModel.dart';

class CustomMemberList extends StatefulWidget {
  final List<Member> members;
  final bool? showPaymentInfo;
  final bool owner;

  const CustomMemberList({super.key, required this.members , this.showPaymentInfo = false, required this.owner});

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
          showToggle: widget.showPaymentInfo ?? false,
          toggleValue: _paymentStatus(widget.members[index]),
          title: '${widget.members[index].name}',
          subtitle: '${widget.members[index].phoneNumber}',
          onToggle: (value){
            print('Fees toggled');
          },
          onTap: widget.owner ? (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MemberDetailScreen(member: widget.members[index])));
          } : Provider.of<TrainerProvider>(context,listen: true).trainer.canSeeMobileNumbers??false ? (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MemberDetailScreen(member: widget.members[index])));
          } : null,
        );
      },
    );
  }

  bool _paymentStatus(Member member) {
    if (member.paymentRecords != null && member.paymentRecords!.isNotEmpty) {
      DateTime lastPaymentExpiryDate = member.paymentRecords!.last.expireDate;
      if (lastPaymentExpiryDate.isAfter(DateTime.now())) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

}
