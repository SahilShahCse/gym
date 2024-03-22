import 'package:flutter/material.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomTrainerList.dart';
import 'package:provider/provider.dart';

import '../../models/MemberModel.dart';
import '../../models/TrainerModel.dart';
import '../../widgets/CustomMemberList.dart';

class MembersListScreen extends StatefulWidget {
  const MembersListScreen({super.key});

  @override
  State<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('M E M B E R S', style: TextStyle(color: Color(0xff720455))),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Consumer<MemberProvider>(
            builder: (context, memberProvider, _) {
              List<Member> members = memberProvider.members;

              return CustomMemberList(
                owner: true,
                members: members,
                showPaymentInfo: true,

              );
            },
          ),
        ),
      ),
    );
  }
}
