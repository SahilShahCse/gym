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
      appBar:  AppBar(
        title: Text('T R A I N E R S', style: TextStyle(color: Color(0xff720455))),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Consumer<TrainerProvider>(
            builder: (context, trainerProvider, _) {
              List<Trainer> trainers = trainerProvider.trainers;
          
              return CustomTrainersList(
                showOnlineStatus: true,
                trainers: trainers,
              );
            },
          ),
        ),
      ),
    );
  }
}
