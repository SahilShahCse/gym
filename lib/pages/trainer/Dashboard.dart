import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gym/models/MemberModel.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomList.dart';
import 'package:gym/widgets/custom_list_tile.dart';
import 'package:provider/provider.dart';

import '../../models/TrainerModel.dart';
import '../../widgets/CustomMemberList.dart';
import '../../widgets/CustomTrainerList.dart';

class TrainerDashboard extends StatefulWidget {
  const TrainerDashboard({Key? key}) : super(key: key);

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  @override
  void initState() {
    setData();

    super.initState();
  }

  String _selected = '';

  Future<void> setData() async {
    String gymCode =
        Provider.of<TrainerProvider>(context, listen: false).trainer.gymCode!;

    Provider.of<MemberProvider>(context, listen: false)
        .fetchMembersByGymCode(gymCode);
    Provider.of<TrainerProvider>(context,listen: false).listenToTrainerUpdates();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // trainer details
              CustomListTile(
                title: 'Status',
                subtitle: Provider.of<TrainerProvider>(context, listen: false)
                            .trainer
                            .isInGym ??
                        false
                    ? 'in Gym'
                    : 'Not In Gym',
                showToggle: true,
                toggleValue:  Provider.of<TrainerProvider>(context, listen: false).trainer.isInGym??false,
                onToggle: (value) {
                    Provider.of<TrainerProvider>(context, listen: false)
                        .toggleGymAttendance();
                    setState(() {});
                },
              ),
              SizedBox(height: 16),
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
                      'Expired Member',
                      'No Diet',
                      'No Workout',
                      'Expiring(5 days)',

                    ],
                    subtitle: [
                      '${members.length}',
                      '${members.where((member) => member.membershipExpiryDate != null && member.membershipExpiryDate!.isBefore(DateTime.now())).length}',
                      '${members.where((member) => member.diet == null || member.diet!.isEmpty).length}',
                      '${members.where((member) => member.workout == null || member.workout!.isEmpty).length}',
                      '${members.where((member) => member.membershipExpiryDate != null && member.membershipExpiryDate!.isBefore(DateTime.now().add(Duration(days: 5)))).length}',
                    ],
                    onTap: [
                      () {
                        _selected = 'Total Members';
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

              (data.isNotEmpty)
                  ? CustomMemberList(members: data.cast<Member>() , owner: false,)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
