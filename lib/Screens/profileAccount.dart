import 'package:compositiontodaymobile1/Screens/CreatePostPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User ID: ${user.uid}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateJobPostPage()),
                );
              },
              child: Text('Create Post'),
            ),
            SizedBox(height: 16),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login/register screen or any other screen after sign out
    } catch (e) {
      // Handle sign out errors
      print('Error signing out: $e');
      // You can show a snackbar or dialog to inform the user about the error
    }
  }
}
