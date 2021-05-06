import 'package:firebase_auth/firebase_auth.dart';
import '../components/or_divider.dart';
import '../components/social_icon.dart';
import 'home.dart';
import 'signup.dart';
import '../session/session_management.dart';
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
                      "assets/images/login.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                emailInput(),
                passwordInput(),
                loginBtn(),
                signupWidget(),
                OrDivider(),
                socialLogin(),
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
        autocorrect: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.deepPurple,
          ),
          labelText: "Email",
          hintText: "user@domain.com",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
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
          labelText: "Password",
          hintText: "Enter a strong password",
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(42.0)),
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
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  void performLogin() async {
    if (_formKey.currentState.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailCtrl.text,
          password: _pwdCtrl.text,
        );
        User user = userCredential.user;
        if (user.emailVerified) {
          notifyUser(context, 'Logging you in..');
          SessionManagement.storeLoggedInDetails(uid: user.uid);
          Navigator.pushNamed(context, HomeScreen.ROUTE_HOME);
        } else {
          notifyUser(context, 'Please verify your email address.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          notifyUser(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          notifyUser(context, 'Wrong password provided for that user.');
        }
      }
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

  Widget socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          iconSrc: "assets/icons/facebook.svg",
          press: () {},
        ),
        SocialIcon(
          iconSrc: "assets/icons/twitter.svg",
          press: () {},
        ),
        SocialIcon(
          iconSrc: "assets/icons/google.svg",
          press: () {},
        ),
      ],
    );
  }

  void notifyUser(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
      ),
    );
  }
}
