import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompositionOpportunityForm extends StatefulWidget {
  @override
  _CompositionOpportunityFormState createState() => _CompositionOpportunityFormState();
}

class _CompositionOpportunityFormState extends State<CompositionOpportunityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _genre = 'Alternative';
  String _link = '';
  String _awards = '';
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
            onSaved: (value) {
              _title = value!;
            },
          ),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Genre'),
            value: _genre,
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
                _genre = value!;
              });
            },
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
            decoration: InputDecoration(labelText: 'Awards (if any)'),
            onChanged: (value) {
              setState(() {
                _awards = value;
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


          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, you can submit data here
                // Example: call a function to submit data to the API
                setState(() {
                  _isLoading = true;
                });
                submitCompositionPost();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> submitCompositionPost() async {
    // Here you can submit the job post to your API
    // Construct the job post object using the form data
    // Send a POST request to your API endpoint with the job post data
    print('Submitting job post...');
    print('Title: $_title');
    print('Link: $_link');
    print('Awards: $_awards');
    print('Description: $_description');
    try {
      // HTTP request example
      final response = await http.post(
        Uri.parse('https://your-api-endpoint.com/create-post'),
        body: {
          'opportunityType': 'jobs',
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
