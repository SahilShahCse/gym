import 'package:flutter/material.dart';
import 'package:gym/models/TrainerModel.dart';
import 'package:gym/pages/trainerInfoAdmin/trainer_detail_page.dart';
import 'package:provider/provider.dart';

import '../../providers/TrainerProvider.dart';

class TrainersListPage extends StatefulWidget {
  const TrainersListPage({super.key});

  @override
  State<TrainersListPage> createState() => _TrainersListPageState();
}

class _TrainersListPageState extends State<TrainersListPage> {

  List<Trainer> trainers = [
    Trainer(
      id: 'T001',
      name: 'Alice Smith',
      contact: '+1234567890',
      emailId: 'alice@example.com',
      address: '456 Oak Street, City',
      salary: 60000,
      shift: 'Morning',
      personalTrainingId: ['PT003', 'PT004'],
    ),
    Trainer(
      id: 'T002',
      name: 'Bob Johnson',
      contact: '+1987654321',
      emailId: 'bob@example.com',
      address: '789 Maple Avenue, Town',
      salary: 55000,
      shift: 'Evening',
      personalTrainingId: ['PT005'],
    ),
    // Add more Trainer objects as needed
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('Trainers'),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: trainers.length,
            itemBuilder: (BuildContext context, int index){
              Trainer trainer = trainers[index];
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>TrainerDetailPage(trainer: trainer)));
            },
            title: Text('${trainer.name}'),
          );
        }),
      ),
    );
  }
}
