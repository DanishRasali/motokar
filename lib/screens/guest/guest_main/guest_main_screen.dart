import 'package:flutter/material.dart';

import 'package:motokar/screens/guest/guest_explore/guest_explore_view.dart';
import 'package:motokar/screens/guest/guest_trips/guest_trips_view.dart';
import 'package:motokar/screens/guest/guest_post/guest_post_view.dart';
import 'package:motokar/screens/guest/guest_profile/guest_profile_view.dart';

class GuestMainScreen extends StatefulWidget {
  GuestMainScreen({this.tab});
  int tab;

  @override
  _GuestMainScreenState createState() => _GuestMainScreenState();
}

class _GuestMainScreenState extends State<GuestMainScreen> {
  int _selectedIndex = 0;
  Widget _currentScreen;

  get selectedIndex => _selectedIndex;
  set selectedIndex(value) => setState(() => _selectedIndex = value);

  get currentScreen => _currentScreen;
  set currentScreen(value) => setState(() => _currentScreen = value);

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.tab;
    if (selectedIndex == 0) {
      currentScreen = GuestExploreView();
    }
    if (selectedIndex == 1) {
      currentScreen = GuestTripsView();
    }
    if (selectedIndex == 2) {
      currentScreen = GuestPostView();
    }
    if (selectedIndex == 3) {
      currentScreen = GuestProfileView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: _buildTabBar(),
    );
  }

  BottomNavigationBar _buildTabBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'EXPLORE',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.near_me),
          label: 'BOOKINGS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.post_add),
          label: 'POSTS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'PROFILE',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Color.fromRGBO(253, 121, 168, 1),
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    selectedIndex = index;

    if (selectedIndex == 0) {
      currentScreen = GuestExploreView();
    }
    if (selectedIndex == 1) {
      currentScreen = GuestTripsView();
    }
    if (selectedIndex == 2) {
      currentScreen = GuestPostView();
    }
    if (selectedIndex == 3) {
      currentScreen = GuestProfileView();
    }
  }
}
