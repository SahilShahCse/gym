import 'package:flutter/material.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';

import '../../widgets/CustomList.dart';

class ProfileScreenForTrainer extends StatelessWidget {
  const ProfileScreenForTrainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trainer = Provider.of<TrainerProvider>(context).trainer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomList(
              title: [
                'Name',
                'Email',
                'Phone Number',
                'Address',
                'Salary',
                'Shift',
                'Gym Code',
                'Is in Gym',
                'Age',
                'Gender',
                'Can See Mobile Numbers',
                'Can Update Payment Status',
              ],
              subtitle: [
                trainer.name ?? 'Not available',
                trainer.emailId ?? 'Not available',
                trainer.phoneNumber ?? 'Not available',
                trainer.address ?? 'Not available',
                trainer.salary != null ? '\$${trainer.salary}' : 'Not available',
                trainer.shift ?? 'Not available',
                trainer.gymCode ?? 'Not available',
                trainer.isInGym != null ? (trainer.isInGym! ? 'Yes' : 'No') : 'Not available',
                trainer.age != null ? trainer.age.toString() : 'Not available',
                trainer.gender ?? 'Not available',
                trainer.canSeeMobileNumbers != null ? (trainer.canSeeMobileNumbers! ? 'Yes' : 'No') : 'Not available',
                trainer.canUpdatePaymentStatus != null ? (trainer.canUpdatePaymentStatus! ? 'Yes' : 'No') : 'Not available',
              ],
              onTap: List.generate(12, (index) => null), // No onTap actions for now
            ),
          ],
        ),
      ),
    );
  }
}
