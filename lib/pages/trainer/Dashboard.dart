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

  String _selected = 'totalMembers';

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
      case 'totalMembers':
        return memberProvider.members;
      case 'expiredMember':
        return memberProvider.members
            .where((member) =>
        member.membershipExpiryDate != null &&
            member.membershipExpiryDate!.isBefore(DateTime.now()))
            .toList();
      case 'noDiet':
        return memberProvider.members
            .where((member) => member.diet == null || member.diet!.isEmpty)
            .toList();
      case 'noWorkout':
        return memberProvider.members
            .where(
                (member) => member.workout == null || member.workout!.isEmpty)
            .toList();
      case 'expiringIn5Days':
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
        title: Text('Dashboard'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              // trainer details
              Consumer<TrainerProvider>(
                builder: (context, trainerProvider, _) {
                  Trainer trainer = trainerProvider.trainer;
                  return CustomList(
                    title: const [
                      'Name',
                      'Gym Code',
                      'Contact Number',
                      'Email',
                      'Address',
                    ],
                    subtitle: [
                      trainer.name,
                      trainer.gymCode,
                      trainer.phoneNumber,
                      trainer.emailId ?? 'Not Given',
                      trainer.address ?? 'Not Given',
                    ],
                    onTap: [],
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
                        _selected = 'totalMembers';
                        setState(
                              () {},
                        );
                      },
                          () {
                        _selected = 'expiredMember';
                        setState(
                              () {},
                        );
                      },
                          () {
                        _selected = 'noDiet';
                        setState(
                              () {},
                        );
                      },
                          () {
                        _selected = 'noWorkout';
                        setState(
                              () {},
                        );
                      },
                          () {
                        _selected = 'expiringIn5Days';
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
              (data.isNotEmpty)
                  ? CustomMemberList(members: data.cast<Member>())
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
