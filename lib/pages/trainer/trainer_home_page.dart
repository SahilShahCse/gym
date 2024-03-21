import 'package:flutter/material.dart';
import 'package:gym/models/MemberModel.dart';
import 'package:gym/pages/trainer/Dashboard.dart';
import 'package:gym/pages/trainer/PaymentInfoScreen.dart';
import 'package:gym/pages/trainer/PersonalTrainingDetailScreen.dart';
import 'package:gym/providers/MemberProvider.dart';
import 'package:gym/providers/TrainerProvider.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_bottom_navigationbar.dart';
import 'ProfileScreenForTrainer.dart';

class TrainerHomePage extends StatefulWidget {
  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
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
      body: _buildBody(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onNavItemPressed: _onNavItemPressed,
        customIcons: [
          Icons.dashboard_outlined,
          Icons.sports_gymnastics,
          Icons.import_export_sharp,
          Icons.person,
        ],
      ),
    );
  }
  

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: <Widget>[
                TrainerDashboard(),
                PersonalTrainingDetailScreen(),
                PaymentInfoScreen(),
                ProfileScreenForTrainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavItemPressed(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }
}