import 'package:first_app/screens/signup.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const ROUTE_LOGIN = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Image.asset(
                      "assets/images/login.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                emailInput(),
                passwordInput(),
                loginBtn(),
                signupWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "user@domain.com",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.cyan,
              style: BorderStyle.solid,
              width: 4.0,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter an email address";
          }
          return null;
        },
        controller: _emailCtrl,
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter a strong password",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.cyan,
              style: BorderStyle.solid,
              width: 4.0,
            ),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter a strong password";
          } else if (value.length < 8) {
            return "Password must be atleast 8 characters long";
          }
          return null;
        },
        controller: _pwdCtrl,
      ),
    );
  }

  Widget loginBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
        onPressed: performLogin,
        child: Text(
          "Log In",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'productSans',
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 50),
          elevation: 20,
        ),
      ),
    );
  }

  void performLogin() {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Processing Data'),
        ),
      );
    }
  }

  Widget signupWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New User?',
          style: TextStyle(
            fontFamily: 'productSans',
            fontSize: 15.0,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, SignupScreen.ROUTE_SIGNUP);
          },
          child: Text(
            ' Sign Up Now !',
            style: TextStyle(
              fontFamily: 'productSans',
              fontSize: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
