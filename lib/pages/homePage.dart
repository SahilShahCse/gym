import 'package:flutter/material.dart';
import 'package:gym/pages/loginPage.dart';
import 'package:gym/pages/logout.dart';
import 'package:gym/pages/trainerInfoAdmin/trainers_list.dart';
import 'package:gym/pages/userInfoAdmin/client_info_page.dart';
import 'package:gym/pages/userInfoAdmin/user_detail_page.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';

import '../models/MemberModel.dart';
import 'feeReminder/fee_reminder_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: <Widget>[
                  ClientsListPage(),
                  TrainersListPage(),
                  LogoutPage(),
                  ManageMembersPage(),
                ],
              ),
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildIconButton(Icons.people, 0),
                  _buildIconButton(Icons.fitness_center, 1),
                  _buildIconButton(Icons.brunch_dining, 2),
                  _buildIconButton(Icons.payment, 3),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, int index) {
    return Expanded(
      child: IconButton(
        icon: Icon(
          icon,
          color: _currentIndex == index ? Colors.purple : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
      ),
    );
  }
}
