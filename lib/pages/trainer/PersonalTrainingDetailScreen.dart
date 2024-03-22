import 'package:flutter/material.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomTrainerList.dart';
import 'package:provider/provider.dart';

import '../../models/MemberModel.dart';
import '../../models/TrainerModel.dart';
import '../../widgets/CustomMemberList.dart';

class PersonalTrainingDetailScreen extends StatefulWidget {
  const PersonalTrainingDetailScreen({super.key});

  @override
  State<PersonalTrainingDetailScreen> createState() => _PersonalTrainingDetailScreenState();
}

class _PersonalTrainingDetailScreenState extends State<PersonalTrainingDetailScreen> {


  void setData(){
    String gymCode  = Provider.of<TrainerProvider>(context,listen: false).trainer.gymCode ?? '';
    Provider.of<MemberProvider>(context,listen: false).fetchMembersByGymCode(gymCode);
  }

  @override
  Widget build(BuildContext context) {
    setData();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('T R A I N I N G', style: TextStyle(color: Color(0xff720455))),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Consumer<MemberProvider>(
            builder: (context, memberProvider, _) {
              List<Member> members = memberProvider.members.where((element) => element.trainerId == Provider.of<TrainerProvider>(context , listen:  false).trainer.id).toList();
              return CustomMemberList(
                members: members,
                owner: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
