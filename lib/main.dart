import 'package:first_app/screens/login.dart';
import 'package:first_app/screens/signup.dart';
import 'package:first_app/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Root widget for the widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Root Widget',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // home: SplashScreen(),
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        LoginScreen.ROUTE_LOGIN: (context) => LoginScreen(),
        SignupScreen.ROUTE_SIGNUP: (context) => SignupScreen(),
      },
    );
  }
}
