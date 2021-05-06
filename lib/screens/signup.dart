import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
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
          } else if (value.length < 8) {
            return "Password must be at least 8 characters long";
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

  void performSignup() async {
    String name = _nameCtrl.text;
    String email = _emailCtrl.text;
    String password = _pwdCtrl.text;
    if (_formKey.currentState.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User _currentUser = userCredential.user;
        _currentUser.sendEmailVerification(); //Send Verification Link
        storeUserDetails(_currentUser.uid, name, email); //Store these details
        notifyUser(
          context,
          'An email with verification link has been sent to you.',
        );
        Navigator.pushNamed(context, LoginScreen.ROUTE_LOGIN);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          notifyUser(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          notifyUser(context, 'The account already exists for that email.');
        }
      } catch (e) {
        notifyUser(context, e);
      }
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

  void notifyUser(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
      ),
    );
  }

  void storeUserDetails(String uid, String name, String email) async {
    Map<String, dynamic> userDetails = {
      "name": name,
      "email": email,
      "desc": "Nothing to share at the moment!",
      "image": "",
    };
    await FirebaseFirestore.instance
        .collection('users') // Create collection
        .doc(uid) // Create a new document with uid
        .set(userDetails) // Set the user details to that document
        .then(
          (_) => notifyUser(context, 'You have been registered successfully!'),
        )
        .catchError(
          (onError) => notifyUser(context, onError),
        );
  }
}
