import 'package:flutter/material.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:gym/widgets/CustomTrainerList.dart';
import 'package:provider/provider.dart';

import '../../models/TrainerModel.dart';

class TrainersListScreen extends StatefulWidget {
  const TrainersListScreen({super.key});

  @override
  State<TrainersListScreen> createState() => _TrainersListScreenState();
}

class _TrainersListScreenState extends State<TrainersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Trainers'),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Consumer<TrainerProvider>(
            builder: (context, trainerProvider, _) {
              List<Trainer> trainers = trainerProvider.trainers;
          
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0),
                child: CustomTrainersList(
                  trainers: trainers,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
