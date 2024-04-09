import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateCompetitionForm extends StatefulWidget {
  @override
  _CreateCompetitionFormState createState() => _CreateCompetitionFormState();
}

class _CreateCompetitionFormState extends State<CreateCompetitionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _organization = '';
  double _fee = 0.0;
  String _category = '';
  DateTime _deadline = DateTime.now();
  String _link = '';
  String _description = '';

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            onChanged: (value) {
              _title = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Organization'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an organization';
              }
              return null;
            },
            onSaved: (value) {
              _organization = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Fee'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null) {
                try {
                  double.parse(value);
                  return null;
                } catch (e) {
                  return 'Please enter only numbers for the salary';
                }
              }
            },
            onSaved: (value) {
              _organization = value!;
            },
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Category'),
            items: const [
              DropdownMenuItem(
                value: 'Alternative',
                child: Text('Alternative'),
              ),
              DropdownMenuItem(
                value: 'Ballads/Romantic',
                child: Text('Ballads/Romantic'),
              ),
              DropdownMenuItem(
                value: 'Blues',
                child: Text('Blues'),
              ),
              DropdownMenuItem(
                value: "Children's Music",
                child: Text("Children's Music"),
              ),
              DropdownMenuItem(
                value: 'Classical',
                child: Text('Classical'),
              ),
              DropdownMenuItem(
                value: 'Country',
                child: Text('Country'),
              ),
              DropdownMenuItem(
                value: 'Electronic',
                child: Text('Electronic'),
              ),
              DropdownMenuItem(
                value: 'Folk',
                child: Text('Folk'),
              ),
              DropdownMenuItem(
                value: 'Hip-Hop',
                child: Text('Hip-Hop'),
              ),
              DropdownMenuItem(
                value: 'Holiday',
                child: Text('Holiday'),
              ),
              DropdownMenuItem(
                value: 'Jazz',
                child: Text('Jazz'),
              ),
              DropdownMenuItem(
                value: 'Latin',
                child: Text('Latin'),
              ),
              DropdownMenuItem(
                value: 'Medieval/Renaissance',
                child: Text('Medieval/Renaissance'),
              ),
              DropdownMenuItem(
                value: 'Metal',
                child: Text('Metal'),
              ),
              DropdownMenuItem(
                value: 'New Age',
                child: Text('New Age'),
              ),
              DropdownMenuItem(
                value: 'Pop',
                child: Text('Pop'),
              ),
              DropdownMenuItem(
                value: 'R&B',
                child: Text('R&B'),
              ),
              DropdownMenuItem(
                value: 'Rap',
                child: Text('Rap'),
              ),
              DropdownMenuItem(
                value: 'Reggae',
                child: Text('Reggae'),
              ),
              DropdownMenuItem(
                value: 'Religious',
                child: Text('Religious'),
              ),
              DropdownMenuItem(
                value: 'Rock',
                child: Text('Rock'),
              ),
              DropdownMenuItem(
                value: 'World',
                child: Text('World'),
              ),
              DropdownMenuItem(
                value: 'Other',
                child: Text('Other'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _category = value!;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Application Deadline'),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _deadline,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                setState(() {
                  _deadline = selectedDate;
                });
              }
            },
            readOnly: true,
            controller: TextEditingController(text: '${_deadline.toLocal()}'.split(' ')[0]),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Link'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the link';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _link = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: null,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the description';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
          ),
          // Add more form fields for deadline, link, and description
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, you can submit data here
                // Example: call a function to submit data to the API
                setState(() {
                  _isLoading = true;
                });
                submitFestivalPost();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> submitFestivalPost() async {
    // Here you can submit the job post to your API
    // Construct the job post object using the form data
    // Send a POST request to your API endpoint with the job post data
    print('Submitting job post...');
    print('Title: $_title');
    print('Organization: $_organization');
    print('Fee: $_fee');
    print('Deadline: $_deadline');
    print('Link: $_link');
    print('Description: $_description');
    try {
      DateTime now = DateTime.now();
      int unixTimeMilliseconds = now.millisecondsSinceEpoch;
      int deadline = _deadline.microsecondsSinceEpoch;

      // HTTP request example
      final response = await http.post(
        Uri.parse('https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/comeptitions'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "UID": "Xty1nS1JHrZzv6tLLdSkcsOWyhF2",
          "title": _title,
          "description": _description,
          "link": _link,
          "date_posted": unixTimeMilliseconds,
          "end_date": deadline,
          "organization": _organization,
          "type": "festivals",
          "city": null,
          "state": null,
          "is_flagged": '0',
          "is_deleted": '0',
          "deleted_comment": null,
          "salary": null,
          "job_type": null,
          "job_category": _category,
          "winner": "",
          "competition_category": null,
          "start_date": null,
          "address": null,
          "start_time": null,
          "fee": null,
          "deadline": deadline,
          "is_scraped": 2,
          "genre": null,
          "published_date": null,
          "hasbeenfeatured": null,
          "likecount": 0,
          "writer": null,
          "awards": null
        }),
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
