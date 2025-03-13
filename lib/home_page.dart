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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google SignIn'),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(Buttons.google,
            text: 'Sign up with Google', onPressed: _handleGoogleSignIn,
            ),
      ),
    );
  }

  Widget _signOutButton() {
    return Center();
  }

  Widget _userInfo() {
    return SizedBox(

      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            // backgroundImage: NetworkImage(_user!.photoURL!),
            // radius: 50,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(_user!.photoURL!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Name: ${_user!.displayName}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'Email: ${_user!.email}',
            style: const TextStyle(fontSize: 20),
          ),
          MaterialButton(
            color: Colors.red,
            child: const Text('Sign Out'),
            onPressed: _auth.signOut,
          ),
        ],
        //   const SizedBox(height: 10),
        //   ElevatedButton(
        //     onPressed: () {}, // _handleSignOut,
        //     child: const Text('Sign Out'),
        //   ),
        // ],
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleProvider);
    } catch (e) {
      print(e);
    }
  }
}
