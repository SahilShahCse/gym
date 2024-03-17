import 'package:flutter/material.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {

  Map<String, String> diet = {
    'Monday': 'Breakfast: 3 boiled eggs\n'
        'Snack: Greek yogurt with honey\n'
        'Lunch: Grilled chicken salad\n'
        'Snack: Apple slices with almond butter\n'
        'Dinner: Baked salmon with quinoa and steamed broccoli',

    'Tuesday': 'Breakfast: Oatmeal with berries and almonds\n'
        'Lunch: Turkey and avocado wrap with whole-grain tortilla\n'
        'Snack: Cottage cheese with pineapple chunks\n'
        'Dinner: Stir-fried tofu with vegetables and brown rice',

    'Wednesday': 'Breakfast: Greek yogurt with honey\n'
        'Lunch: Lentil soup with whole-grain bread\n'
        'Snack: Celery sticks with peanut butter\n'
        'Dinner: Grilled shrimp skewers with quinoa pilaf and roasted asparagus',

    'Thursday': 'Breakfast: Whole-grain pancakes with berries\n'
        'Lunch: Quinoa salad with chickpeas and vegetables\n'
        'Snack: Sliced cucumber with tzatziki sauce\n'
        'Dinner: Baked chicken breast with sweet potato mash and steamed green beans',

    'Friday': 'Breakfast: Smoothie with spinach, banana, and protein powder\n'
        'Lunch: Spinach and feta omelette with whole-grain toast\n'
        'Snack: Rice cakes with almond butter\n'
        'Dinner: Baked cod with roasted potatoes and steamed carrots',

    'Saturday': 'Breakfast: Avocado toast on whole-grain bread\n'
        'Lunch: Whole-grain pasta salad with grilled vegetables\n'
        'Snack: Pear slices with cheese\n'
        'Dinner: Beef stir-fry with bell peppers and broccoli',

    'Sunday': 'Breakfast: Veggie omelette with whole-grain English muffin\n'
        'Lunch: Grilled vegetable wrap with hummus\n'
        'Snack: Cottage cheese with sliced peaches\n'
        'Dinner: Stuffed bell peppers with ground turkey and quinoa'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Plan'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child:
        ListView.builder(

          itemCount:  diet.keys.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${diet.keys.toList()[index]}' , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 18),),
                  SizedBox(height: 10),
                  Text('${diet[diet.keys.toList()[index]]}'),
                ],
              ),
            );
        },),
      ),
    );
  }
}
