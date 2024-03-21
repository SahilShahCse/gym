import 'package:flutter/material.dart';
import 'package:gym/pages/owner/Dashboard.dart';
import 'package:gym/pages/owner/MembersListScreen.dart';
import 'package:gym/pages/owner/ProfileScreen.dart';
import 'package:gym/pages/owner/TrainersListScreen.dart';

import '../../widgets/custom_bottom_navigationbar.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
          Icons.people_alt_outlined,
          Icons.fitness_center_outlined,
          Icons.person
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
                OwnerDashboard(),
                MembersListScreen(),
                TrainersListScreen(),
                ProfileScreen(),
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
