import 'package:compositiontodaymobile1/Screens/ScreenComponents/ProfileComponents/CompetitonForm.dart';
import 'package:compositiontodaymobile1/Screens/ScreenComponents/ProfileComponents/CompositionForm.dart';
import 'package:compositiontodaymobile1/Screens/ScreenComponents/ProfileComponents/ConcertForm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'ScreenComponents/ProfileComponents/FestivalForm.dart';
import 'ScreenComponents/ProfileComponents/JobForm.dart';

class CreateJobPostPage extends StatefulWidget {
  const CreateJobPostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreateJobPostPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Define your form fields here
  String _opportunityType = "Jobs";
  // Other form fields...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Opportunity Type Dropdown
            DropdownButton<String>(
            value: _opportunityType,
            onChanged: (String? newValue) {
              setState(() {
                _opportunityType = newValue!;
              });
            },
            items: <String>[
              'Jobs', // Make sure each value is unique
              'Competitions',
              'Festivals',
              'Concerts',
              'Compositions',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
              if(_opportunityType == "Jobs")
                CreateJobOpportunityForm(),
              if(_opportunityType == "Competitions")
                CreateCompetitionForm(),
              if(_opportunityType == "Festivals")
                FestivalOpportunityForm(),
              if(_opportunityType == "Concerts")
                ConcertOpportunityForm(),
              if(_opportunityType == "Compositions")
                CompositionOpportunityForm(),


            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Form fields validation passed, proceed to create post
      setState(() {
        _isLoading = true;
      });

      // Define your post creation logic here
      // You can use the _opportunityType and other form field values to create the post
      // Example: Send HTTP request to your backend API to create the post

      try {
        // HTTP request example
        final response = await http.post(
          Uri.parse('https://your-api-endpoint.com/create-post'),
          body: {
            'opportunityType': _opportunityType,
            // Other form field values...
          },
        );

        // Check if the request was successful
        if (response.statusCode == 200) {
          // Post created successfully
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Post created successfully'),
              duration: Duration(seconds: 2),
            ),
          );
          // Navigate to desired screen after successful post creation
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => YourDesiredScreen()));
        } else {
          // Request failed, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create post. Please try again later.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print('Error creating post: $e');
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
