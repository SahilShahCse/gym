import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/MemberModel.dart';
import '../../providers/MemberProvider.dart';

class DietPage extends StatefulWidget {
  final Member member;
  const DietPage({Key? key, required this.member});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  List<Widget> dietWidgets = [];
  List<Information> dietData = [];

  @override
  void initState() {
    super.initState();
    // Check if the member object has diet data, if yes, add it to dietData list
    if (widget.member.diet != null) {
      dietData.addAll(widget.member.diet!);
      dietWidgets.addAll(widget.member.diet!.map((diet) => _buildDietEntry(dietData.indexOf(diet))));
    }
    // Add initial diet widget if dietData is empty
    if (dietData.isEmpty) {
      addDietWidget();
    }
  }

  void addDietWidget() {
    setState(() {
      dietData.add(Information(heading: '', description: ''));
      dietWidgets.add(
        _buildDietEntry(dietData.length - 1), // Pass the index of the last diet entry
      );
    });
  }

  void removeDietWidget() {
    setState(() {
      if (dietWidgets.isNotEmpty) {
        dietWidgets.removeLast();
        dietData.removeLast();
      }
    });
  }

  void submitDietPlan() {
    Provider.of<MemberProvider>(context, listen: false).updateDiet(widget.member.id, dietData);
  }

  Widget _buildDietEntry(int index) {
    TextEditingController titleController = TextEditingController(text: dietData[index].heading);
    TextEditingController dietController = TextEditingController(text: dietData[index].description);

    // Add listener to update dietData list when text fields change
    titleController.addListener(() {
      setState(() {
        dietData[index].heading = titleController.text;
      });
    });

    dietController.addListener(() {
      setState(() {
        dietData[index].description = dietController.text;
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
          controller: dietController,
          decoration: InputDecoration(
            hintText: 'Enter diet plan',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Plan'),
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: addDietWidget,
              icon: Icon(Icons.add),
            ),
            SizedBox(width: 8.0),
            IconButton(
              onPressed: removeDietWidget,
              icon: Icon(Icons.remove),
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: submitDietPlan,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ...dietWidgets.map((dietWidget) => Column(
              children: [
                dietWidget,
                SizedBox(height: 8.0),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
