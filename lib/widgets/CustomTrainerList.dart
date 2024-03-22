import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/owner/TrainerDetailPage.dart';
import 'package:gym/widgets/custom_list_tile.dart';

import '../models/MemberModel.dart';
import '../models/TrainerModel.dart';

class CustomTrainersList extends StatefulWidget {

  final List<Trainer> trainers;
  final bool showOnlineStatus;

  const CustomTrainersList({super.key, required this.trainers , this.showOnlineStatus = false});

  @override
  State<CustomTrainersList> createState() => _CustomTrainersListState();
}

class _CustomTrainersListState extends State<CustomTrainersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.trainers.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomListTile(
          title: '${widget.trainers[index].name}',
          subtitle: '${widget.trainers[index].phoneNumber}',
          showToggle: widget.showOnlineStatus ?? false,
          toggleColor: Colors.green,
          toggleColorBackground: Colors.teal,
          toggleValue: widget.trainers[index].isInGym ?? false,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>TrainerDetailPage(trainer: widget.trainers[index])));
          },
        );
      },
    );
  }
}
