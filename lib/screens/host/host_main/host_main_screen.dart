import 'package:flutter/material.dart';

import 'package:motokar/screens/host/host_explore/host_explore_view.dart';
import 'package:motokar/screens/host/host_trips/host_trips_view.dart';
import 'package:motokar/screens/host/host_garage/host_garage_view.dart';
import 'package:motokar/screens/host/host_post/host_post_view.dart';
import 'package:motokar/screens/host/host_profile/host_profile_view.dart';

class HostMainScreen extends StatefulWidget {
  HostMainScreen({this.tab});
  int tab;

  @override
  _HostMainScreenState createState() => _HostMainScreenState();
}

class _HostMainScreenState extends State<HostMainScreen> {
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
      currentScreen = HostExploreView();
    }
    if (selectedIndex == 1) {
      currentScreen = HostTripsView();
    }
    if (selectedIndex == 2) {
      currentScreen = HostGarageView();
    }
    if (selectedIndex == 3) {
      currentScreen = HostPostView();
    }
    if (selectedIndex == 4) {
      currentScreen = HostProfileView();
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
          icon: Icon(Icons.home),
          label: 'HOMES',
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
      currentScreen = HostExploreView();
    }
    if (selectedIndex == 1) {
      currentScreen = HostTripsView();
    }
    if (selectedIndex == 2) {
      currentScreen = HostGarageView();
    }
    if (selectedIndex == 3) {
      currentScreen = HostPostView();
    }
    if (selectedIndex == 4) {
      currentScreen = HostProfileView();
    }
  }
}
