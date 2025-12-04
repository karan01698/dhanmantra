import 'package:flutter/material.dart';
import 'package:sattagames/NewGames/games/spinner/Mobilespinner.dart';

import 'bikeSpinner.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spinner Screen', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          // Set the tab indicator color to white
          labelColor: Colors.white,
          // Set the tab text color to white
          unselectedLabelColor: Colors.grey,
          // Optionally set unselected tab text color
          tabs: [
            Tab(
              child: Text(
                'Mobile Wheel Spinner',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Bike Wheel Spinner',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MobileSpinnerl(), // First class widget
          BikeSpinner(), // Second class widget
        ],
      ),
    );
  }
}
