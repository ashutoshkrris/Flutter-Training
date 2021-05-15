import 'package:first_app/screens/conversations.dart';
import 'package:first_app/screens/home.dart';
import 'package:first_app/screens/login.dart';
import 'package:first_app/screens/signup.dart';
import 'package:first_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        HomeScreen.ROUTE_HOME: (context) => HomeScreen(),
      },
    );
  }
}
