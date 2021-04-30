import 'package:first_app/screens/login.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const ROUTE_SIGNUP = "/signup";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;

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
                      "assets/images/signup.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                nameInput(),
                emailInput(),
                passwordInput(),
                signupBtn(),
                signupWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameInput() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Name",
          hintText: "Ashutosh Krishna",
          prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.deepPurple,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
              style: BorderStyle.solid,
              width: 4.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
        ),
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your name";
          }
          return null;
        },
        controller: _nameCtrl,
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.deepPurple,
          ),
          labelText: "Email",
          hintText: "user@domain.com",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
              style: BorderStyle.solid,
              width: 4.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
            borderSide: BorderSide(color: Colors.green, width: 2),
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
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.deepPurple,
          ),
          suffixIcon: GestureDetector(
            onTap: _togglePasswordView,
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: Colors.deepPurple,
            ),
          ),
          labelText: "Password",
          hintText: "Enter a strong password",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
              style: BorderStyle.solid,
              width: 4.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: _isHidden,
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget signupBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
        onPressed: performSignup,
        child: Text(
          "Sign Up",
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
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  void performSignup() {
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
          'Already Registered?',
          style: TextStyle(
            fontFamily: 'productSans',
            fontSize: 15.0,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.ROUTE_LOGIN);
          },
          child: Text(
            ' Login Now !',
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
