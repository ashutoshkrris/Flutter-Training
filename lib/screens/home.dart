import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_HOME = "/home";

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('You are in home screen'),
      ),
    );
  }
}
