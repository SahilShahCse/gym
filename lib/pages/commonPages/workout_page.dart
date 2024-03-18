import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/MemberModel.dart';
import '../../providers/MemberProvider.dart';

class WorkoutPage extends StatefulWidget {
  final Member member;
  const WorkoutPage({Key? key, required this.member});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Widget> workoutWidgets = [];
  List<Information> workoutData = [];

  @override
  void initState() {
    super.initState();
    // Check if the member object has workout data, if yes, add it to workoutData list
    if (widget.member.workout != null) {
      workoutData.addAll(widget.member.workout!);
      workoutWidgets.addAll(widget.member.workout!.map((workout) => _buildWorkoutEntry(workoutData.indexOf(workout))));
    }
    // Add initial workout widget if workoutData is empty
    if (workoutData.isEmpty) {
      addWorkoutWidget();
    }
  }

  void addWorkoutWidget() {
    setState(() {
      workoutData.add(Information(heading: '', description: ''));
      workoutWidgets.add(
        _buildWorkoutEntry(workoutData.length - 1), // Pass the index of the last workout entry
      );
    });
  }

  void removeWorkoutWidget() {
    setState(() {
      if (workoutWidgets.isNotEmpty) {
        workoutWidgets.removeLast();
        workoutData.removeLast();
      }
    });
  }

  void submitWorkoutPlan() {
    Provider.of<MemberProvider>(context, listen: false).updateWorkout(widget.member.id, workoutData);
  }

  Widget _buildWorkoutEntry(int index) {
    TextEditingController titleController = TextEditingController(text: workoutData[index].heading);
    TextEditingController workoutController = TextEditingController(text: workoutData[index].description);

    // Add listener to update workoutData list when text fields change
    titleController.addListener(() {
      setState(() {
        workoutData[index].heading = titleController.text;
      });
    });

    workoutController.addListener(() {
      setState(() {
        workoutData[index].description = workoutController.text;
      });
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: 'Title',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: workoutController,
          decoration: InputDecoration(
            hintText: 'Enter workout plan',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          ),
          maxLines: null,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('data received in class : ${widget.member.workout}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Plan'),
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: addWorkoutWidget,
              icon: Icon(Icons.add),
            ),
            SizedBox(width: 8.0),
            IconButton(
              onPressed: removeWorkoutWidget,
              icon: Icon(Icons.remove),
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: submitWorkoutPlan,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ...workoutWidgets.map((workoutWidget) => Column(
              children: [
                workoutWidget,
                SizedBox(height: 8.0),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
