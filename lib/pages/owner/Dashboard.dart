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
      case 'totalTrainers':
        return trainerProvider.trainers;
      case 'inGym':
        return trainerProvider.trainers
            .where((trainer) => trainer.isInGym ?? false)
            .toList();
      case 'numberViewPermission':
        return trainerProvider.trainers
            .where((trainer) => trainer.canSeeMobileNumbers ?? false)
            .toList();
      case 'paymentPermission':
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
        title: Text('Dashboard'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
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
                      'Total Income',
                    ],
                    subtitle: [
                      '${members.length}',
                      '${members.where((member) => member.membershipExpiryDate != null && member.membershipExpiryDate!.isBefore(DateTime.now())).length}',
                      '${members.where((member) => member.diet == null || member.diet!.isEmpty).length}',
                      '${members.where((member) => member.workout == null || member.workout!.isEmpty).length}',
                      '${members.where((member) => member.membershipExpiryDate != null && member.membershipExpiryDate!.isBefore(DateTime.now().add(Duration(days: 5)))).length}',
                      '90,000', // Add logic to calculate total income
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
                      () {
                        _selected = 'totalIncome';
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
                        _selected = 'totalTrainers';
                        setState(() {});
                      },
                      () {
                        _selected = 'inGym';
                        setState(() {});
                      },
                      () {
                        _selected = 'numberViewPermission';
                        setState(() {});
                      },
                      () {
                        _selected = 'paymentPermission';
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
              (data.isNotEmpty && data[0] is Member)
                  ? CustomMemberList(members: data.cast<Member>())
                  :(data.isNotEmpty)? CustomTrainersList(trainers: data.cast<Trainer>()) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
