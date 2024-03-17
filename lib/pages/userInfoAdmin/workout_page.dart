import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  Map<String, String> workout = {
    'Monday': 'Strength Training\n- Squats: 3 sets x 12 reps\n- Bench Press: 3 sets x 10 reps\n- Deadlifts: 3 sets x 8 reps',

    'Tuesday': 'Cardio\n- 30 minutes of jogging or running\n- HIIT workout: 20 minutes (alternating between 30 seconds of high-intensity exercise and 1 minute of rest)',

    'Wednesday': 'Yoga and Stretching\n- Sun Salutations: 3 sets\n- Warrior Pose: 2 sets x 30 seconds each side\n- Seated Forward Bend: 3 sets x 30 seconds each',

    'Thursday': 'Full Body Circuit\n- Jumping Jacks: 3 sets x 30 seconds\n- Push-Ups: 3 sets x 12 reps\n- Lunges: 3 sets x 12 reps each leg\n- Plank: 3 sets x 30 seconds',

    'Friday': 'Upper Body Strength\n- Pull-Ups: 3 sets x 8 reps\n- Dumbbell Rows: 3 sets x 10 reps each arm\n- Shoulder Press: 3 sets x 12 reps',

    'Saturday': 'Active Rest Day\n- Light walk or leisurely bike ride\n- Gentle yoga or stretching session',

    'Sunday': 'HIIT and Abs\n- HIIT workout: 20 minutes\n- Ab Circuit: 3 sets\n  - Bicycle Crunches: 12 reps\n  - Russian Twists: 12 reps\n  - Plank with Leg Lifts: 30 seconds'
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Plan'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child:
        ListView.builder(
          itemCount:  workout.keys.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${workout.keys.toList()[index]}' , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18),),
                  SizedBox(height: 10),
                  Text('${workout[workout.keys.toList()[index]]}'),
                ],
              ),
            );
          },),
      ),
    );
  }
}
