import 'package:compositiontodaymobile1/Screens/profileAccount.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      final User? user = userCredential.user;
      if (user != null) {
        print("loggedIN!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserInfoPage(user: user)),
        );
      }
      // Navigate to home screen or any other desired screen upon successful login
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  Future<void> _register() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to home screen or any other desired screen upon successful registration
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email input
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Password input
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            // Error message display
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            // Login button
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            // Register button
            /*ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),*/
          ],
        ),
      ),
    );
  }
}
