import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? event) {
      setState(() {
        _user = event;
      });
    });
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();

    Widget _googleSignInButton() {
      return Center(
        child: SignInButton(
          Buttons.google,
          text: "Sign up using Google",
          onPressed: () => {},
        ),
      );
    }

    Widget _signOutButton() {
      return Center();
    }

    Widget _userInfo(_userInfo) {
      return SizedBox();
    }
  }
}
