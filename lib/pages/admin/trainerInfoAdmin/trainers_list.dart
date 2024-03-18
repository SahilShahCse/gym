import 'package:flutter/material.dart';
import 'package:gym/components/custom_list_tile.dart';
import 'package:provider/provider.dart';
import '../../../models/TrainerModel.dart';
import '../../../providers/OwnerProvider.dart';
import '../../../providers/TrainerProvider.dart';
import 'trainer_detail_page.dart';

class AdminTrainerPage extends StatefulWidget {
  const AdminTrainerPage({Key? key}) : super(key: key);

  @override
  State<AdminTrainerPage> createState() => _AdminTrainerPageState();
}

class _AdminTrainerPageState extends State<AdminTrainerPage> {
  @override
  void initState() {
    super.initState();
    _fetchTrainers();
  }

  void _fetchTrainers() {
    String gymCode =
        Provider.of<OwnerProvider>(context, listen: false).owner.gymCode;
    Provider.of<TrainerProvider>(context, listen: false)
        .fetchTrainersByGymCode(gymCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainers'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Consumer<TrainerProvider>(
          builder: (context, trainerProvider, _) {
            return trainerProvider.trainers.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildTrainersList(trainerProvider.trainers);
          },
        ),
      ),
    );
  }

  Widget _buildTrainersList(List<Trainer> trainers) {
    return ListView.builder(
      itemCount: trainers.length,
      itemBuilder: (BuildContext context, int index) {
        Trainer trainer = trainers[index];
        return CustomListTile(
          title: '${trainer.name}',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    AdminTrainerDetailPage(trainer: trainer),
              ),
            );
          },
          toggleColor: Colors.white,
          toggleColorBackground: Colors.green,
          subtitle: trainer.isInGym! ? 'Is In Gym' : 'Not In Gym',
          showToggle: true,
          toggleValue: trainer.isInGym!,
          onToggle: (value){},
        );
      },
    );
  }
}
