import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gym/models/MemberModel.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomList.dart';
import 'package:provider/provider.dart';

import '../../models/TrainerModel.dart';
import '../../widgets/CustomMemberList.dart';
import '../../widgets/CustomTrainerList.dart';
import '../../widgets/custom_list_tile.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  @override
  void initState() {
    setData();
    super.initState();
  }

  String _selected = '';

  Future<void> setData() async {
    String gymCode =
        Provider.of<OwnerProvider>(context, listen: false).owner.gymCode!;

     Provider.of<MemberProvider>(context, listen: false)
        .fetchMembersByGymCode(gymCode);
     Provider.of<TrainerProvider>(context, listen: false)
        .fetchTrainersByGymCode(gymCode);
  }

  List<dynamic> getList(String selected) {


    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    final trainerProvider =
        Provider.of<TrainerProvider>(context, listen: false);

    switch (selected) {
      case 'Total Members':
        return memberProvider.members;
      case 'Expired Member':
        return memberProvider.members
            .where((member) =>
                member.membershipExpiryDate != null &&
                member.membershipExpiryDate!.isBefore(DateTime.now()))
            .toList();
      case 'No Diet':
        return memberProvider.members
            .where((member) => member.diet == null || member.diet!.isEmpty)
            .toList();
      case 'No Workout':
        return memberProvider.members
            .where(
                (member) => member.workout == null || member.workout!.isEmpty)
            .toList();
      case 'Expiring In 5 Days':
        return memberProvider.members
            .where((member) =>
                member.membershipExpiryDate != null &&
                member.membershipExpiryDate!
                    .isBefore(DateTime.now().add(Duration(days: 5))))
            .toList();
      case 'Total Trainers':
        return trainerProvider.trainers;
      case 'In Gym':
        return trainerProvider.trainers
            .where((trainer) => trainer.isInGym ?? false)
            .toList();
      case 'Number View Permission':
        return trainerProvider.trainers
            .where((trainer) => trainer.canSeeMobileNumbers ?? false)
            .toList();
      case 'Payment Permission':
        return trainerProvider.trainers
            .where((trainer) => trainer.canUpdatePaymentStatus ?? false)
            .toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {

    List data = getList(_selected);

    return Scaffold(
      appBar: AppBar(
        title: Text('D A S H B O A R D', style: TextStyle(color: Color(0xff720455))),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 0.5,
                  width: double.maxFinite,
                  color: Colors.grey,
                ),
            
                SizedBox(height: 16),


            
                Consumer<MemberProvider>(
                  builder: (context, memberProvider, _) {
                    List<Member> members = memberProvider.members;
                    return CustomList(
                      title: const [
                        'Total Member',
                        'Total Income',

                        'No Diet',
                        'No Workout',
                        'Expiring(5 days)',
                        'Expired Member',

                      ],
                      subtitle: [
                        '${members.length}',
                        '90,000', // Add logic to calculate total income

                        '${members.where((member) => member.diet == null || member.diet!.isEmpty).length}',
                        '${members.where((member) => member.workout == null || member.workout!.isEmpty).length}',
                        '${members.where((member) => member.membershipExpiryDate != null && member.membershipExpiryDate!.isBefore(DateTime.now().add(Duration(days: 5)))).length}',
                        '${members.where((member) => member.membershipExpiryDate != null && member.membershipExpiryDate!.isBefore(DateTime.now())).length}',

                      ],
                      onTap: [
                        () {
                          _selected = 'Total Members';
                          setState(
                            () {},
                          );
                        },
                            () {
                          _selected = 'Total Income';
                          setState(
                                () {},
                          );
                        },
                        () {
                          _selected = 'No Diet';
                          setState(
                            () {},
                          );
                        },
                        () {
                          _selected = 'No Workout';
                          setState(
                            () {},
                          );
                        },
                        () {
                          _selected = 'Expiring In 5 Days';
                          setState(
                            () {},
                          );
                        },

                            () {
                          _selected = 'Expired Member';
                          setState(
                                () {},
                          );
                        },
                      ], // Define onTap callback if needed
                    );
                  },
                ),
                SizedBox(height: 16),
                Container(
                  height: 0.5,
                  width: double.maxFinite,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),

                Consumer<TrainerProvider>(
                  builder: (context, trainerProvider, _) {
                    List<Trainer> trainers = trainerProvider.trainers;
                    return CustomList(
                      title: const [
                        'Total Trainers',
                        'In Gym',
                        'Contact view Permission',
                        'Payment Permission',
                      ],
                      subtitle: [
                        '${trainers.length}', // Assuming you have access to the list of trainers
                        '${trainers.where((trainer) => trainer.isInGym ?? false).length}', // Assuming Trainer model has 'inGym' property
                        '${trainers.where((trainer) => trainer.canSeeMobileNumbers ?? false).length}', // Assuming Trainer model has 'numberViewPermission' property
                        '${trainers.where((trainer) => trainer.canUpdatePaymentStatus ?? false).length}', // Assuming Trainer model has 'paymentPermission' property
                      ],
                      onTap: [
                        () {
                          _selected = 'Total Trainers';
                          setState(() {});
                        },
                        () {
                          _selected = 'In Gym';
                          setState(() {});
                        },
                        () {
                          _selected = 'Number View Permission';
                          setState(() {});
                        },
                        () {
                          _selected = 'Payment Permission';
                          setState(() {});
                        },
                      ], // Define onTap callback if needed
                    );
                  },
                ),
                SizedBox(height: 16),
                Container(
                  height: 0.5,
                  width: double.maxFinite,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                SizedBox(height: 16),
                (data.isNotEmpty)
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '$_selected :',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Color(0xff910A67)),
                  ),
                )
                    : (_selected == '')
                    ? SizedBox()
                    : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'No Data',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Color(0xff910A67)),
                  ),
                ),

                SizedBox(height: 16),

                (data.isNotEmpty && data[0] is Member)
                    ? CustomMemberList(members: data.cast<Member>() , owner: true,)
                    :(data.isNotEmpty)? CustomTrainersList(trainers: data.cast<Trainer>()) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
