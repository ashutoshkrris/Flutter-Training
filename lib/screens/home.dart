import 'package:first_app/data/local_data.dart';
import 'package:first_app/screens/login.dart';
import 'package:first_app/session/session_management.dart';
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
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            onSelected: (_) {},
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.deepPurple,
                  ),
                  label: Text('Log Out'),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                ),
              )
            ],
          )
        ],
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

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you really want to log out?'),
        actions: [
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              SessionManagement.removeLoggedInUser().then((value) {
                if (value) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.ROUTE_LOGIN, (route) => false);
                }
              }); // Log out user
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}
