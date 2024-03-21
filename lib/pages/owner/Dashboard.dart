import 'package:flutter/material.dart';
import 'package:gym/models/MemberModel.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/OwnerProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomList.dart';
import 'package:provider/provider.dart';

import '../../models/TrainerModel.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  @override
  Widget build(BuildContext context) {
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
                    onTap: null, // Define onTap callback if needed
                  );
                },
              ),
              SizedBox(height: 16),
              Container(height: 0.5, width: double.maxFinite, color: Colors.grey,),
              SizedBox(height: 16),
              Consumer<TrainerProvider>(
                builder: (context, trainerProvider, _) {
                  List<Trainer> trainers = trainerProvider.trainers;
                  return CustomList(
                    title: const [
                      'Total Trainers',
                      'In Gym',
                      'Number view Permission',
                      'Payment Permission',
                    ],
                    subtitle: [
                      '${trainers.length}', // Assuming you have access to the list of trainers
                      '${trainers.where((trainer) => trainer.isInGym ?? false).length}', // Assuming Trainer model has 'inGym' property
                      '${trainers.where((trainer) => trainer.canSeeMobileNumbers ?? false).length}', // Assuming Trainer model has 'numberViewPermission' property
                      '${trainers.where((trainer) => trainer.canUpdatePaymentStatus ?? false).length}', // Assuming Trainer model has 'paymentPermission' property
                    ],
                    onTap: null, // Define onTap callback if needed
                  );
                },
              ),
              SizedBox(height: 16),
              Container(height: 0.5, width: double.maxFinite, color: Colors.grey,),
              CustomList(title: [], subtitle: [], onTap: []),
            ],
          ),
        ),
      ),
    );
  }
}

