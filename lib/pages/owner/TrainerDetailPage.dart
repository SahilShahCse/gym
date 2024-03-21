import 'package:flutter/material.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomList.dart';
import 'package:provider/provider.dart';

import '../../models/TrainerModel.dart';

class TrainerDetailPage extends StatefulWidget {
  final Trainer trainer;

  const TrainerDetailPage({Key? key, required this.trainer}) : super(key: key);

  @override
  State<TrainerDetailPage> createState() => _TrainerDetailPageState();
}

class _TrainerDetailPageState extends State<TrainerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer Detail'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Consumer<TrainerProvider>(
            builder: (context, trainerProvider, _) {
              Trainer trainer = trainerProvider.trainers.where((element) => element.id == widget.trainer.id).first;
              return Column(
                children: [
                  CustomList(
                    title: [
                      'Name',
                      'Email',
                      'Contact Number',
                      'Age',
                      'Gender',
                    ],
                    subtitle: [
                      trainer.name,
                      trainer.emailId ?? 'Not Set',
                      trainer.phoneNumber ?? 'Not Set',
                      '${trainer.age ?? 'Not Set'}',
                      trainer.gender ?? 'Not Set',
                    ],
                    onTap: [],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 0.5,
                    width: double.maxFinite,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  CustomList(
                    title: [
                      'Is in Gym',
                      'Personal Training',
                      'Can Update Payment Status',
                      'Can See Mobile Number',
                    ],
                    subtitle: [
                      trainer.isInGym ?? false ? 'Yes' : 'No',
                      (trainer.personalTrainingId != null)
                          ? '${trainer.personalTrainingId!.length}'
                          : '0',
                      trainer.canUpdatePaymentStatus ?? false ? 'Yes' : 'No',
                      trainer.canSeeMobileNumbers ?? false ? 'Yes' : 'No',
                    ],
                    onTap: [
                      null,
                      null,
                          () {
                        trainerProvider.updateTrainerPaymentStatusPermission(
                            trainer.id!,
                            !(trainer.canUpdatePaymentStatus ?? false));
                      },
                          () {
                        trainerProvider.updateTrainerMobileNumberPermission(
                            trainer.id!,
                            !(trainer.canSeeMobileNumbers ?? false));
                      },
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
