import 'package:first_app/data/local_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_HOME = "/home";

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalData.bottomNavList[_selectedTab]["title"]),
      ),
      body: LocalData.bottomNavList[_selectedTab]["screen"],
      bottomNavigationBar: createBottomNav(),
    );
  }

  Widget createBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: LocalData.bottomNavList[0]["title"],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_rounded),
          label: LocalData.bottomNavList[1]["title"],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: LocalData.bottomNavList[2]["title"],
        ),
      ],
      selectedItemColor: Colors.deepPurple,
      currentIndex: _selectedTab,
      onTap: (int tabIndex) {
        setState(() {
          _selectedTab = tabIndex;
        });
      },
    );
  }
}
