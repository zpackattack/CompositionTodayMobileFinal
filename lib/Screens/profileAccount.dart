import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'CreatePostPage.dart';

class UserInfoPage extends StatefulWidget {
  final User user;

  const UserInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      final response = await http.get(
          Uri.parse('https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/users/${widget.user.uid}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body[0]);
        setState(() {
          userName = userData['first_name'];
        });
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle error - show a snackbar or dialog
    }
  }

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

            if (userName != null) Text('Hello, $userName'),
            SizedBox(height: 16),
            Text('${widget.user.email}',
              style: TextStyle(
                color: Color(0xFF454545),
                fontSize: 20,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w500,
              ),),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateJobPostPage()),
                );
              },
              child: Text('Create Post'),
            ),


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
