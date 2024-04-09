import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateJobOpportunityForm extends StatefulWidget {
  @override
  _CreateJobOpportunityFormState createState() =>
      _CreateJobOpportunityFormState();
}

class _CreateJobOpportunityFormState extends State<CreateJobOpportunityForm> {
  String _title = '';
  String _organization = '';
  String _jobType = 'Full-Time'; // Default job type
  String _jobCategory = 'Faculty'; // Default job category
  int _salary = 0;
  String _city = '';
  String _state = '';
  DateTime _deadline = DateTime.now();
  String _link = '';
  String _description = '';
  bool _isRemote = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the title';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Organization'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the organization';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _organization = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _jobType,
              items: [
                'Full-Time',
                'Part-Time',
                'Contractor and Temp Work',
                'Volunteer',
                'Internship'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _jobType = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Job Type'),
            ),
            DropdownButtonFormField<String>(
              value: _jobCategory,
              items: [
                'Faculty',
                'Pre-K Instruction',
                'Elementary Instruction',
                'Junior High Instruction',
                'High School Instruction',
                'Post-Secondary Instruction',
                'Other Instruction',
                'Publishing',
                'Performance',
                'Composing',
                'Other',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _jobCategory = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Job Category'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                    double.parse(value);
                    return null;
                  } catch (e) {
                    return 'Please enter only numbers for the salary';
                  }
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _salary = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'City'),
              enabled: !_isRemote,
              validator: (value) {
                if (!_isRemote && (value == null || value.isEmpty)) {
                  return 'Please enter a city';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _city = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'State'),
              enabled: !_isRemote,
              validator: (value) {
                if (!_isRemote && (value == null || value.isEmpty)) {
                  return 'Please enter a state';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _state = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Remote'),
              value: _isRemote,
              onChanged: (value) {
                setState(() {
                  _isRemote = value!;
                  if (_isRemote) {
                    _city = 'remote';
                    _state = 'remote';
                  }
                });
              },
            ),
            TextFormField(
              decoration:
              InputDecoration(labelText: 'Application Deadline'),
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
              controller: TextEditingController(
                  text: '${_deadline.toLocal()}'.split(' ')[0]),
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, you can submit data here
                  // Example: call a function to submit data to the API
                  setState(() {
                    _isLoading = true;
                  });
                  submitJobPost();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitJobPost() async {
    // Here you can submit the job post to your API
    // Construct the job post object using the form data
    // Send a POST request to your API endpoint with the job post data
    print('Submitting job post...');
    print('Title: $_title');
    print('Organization: $_organization');
    print('Job Type: $_jobType');
    print('Job Category: $_jobCategory');
    print('Salary: $_salary');
    print('City: $_city');
    print('State: $_state');
    print('Deadline: $_deadline');
    print('Link: $_link');
    print('Description: $_description');
    try {
      DateTime now = DateTime.now();
      int unixTimeMilliseconds = now.millisecondsSinceEpoch;
      // HTTP request example
      final response = await http.post(
        Uri.parse('https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/jobs'),
        body: {
          "UID": "Xty1nS1JHrZzv6tLLdSkcsOWyhF2",
          "title": _title,
          "description": _description,
          "link": _link,
          "date_posted": unixTimeMilliseconds,
          "end_date": _deadline.millisecondsSinceEpoch,
          "organization": _organization,
          "type": "jobs",
          "city": _isRemote ? "Remote" : _city,
          "state": _isRemote ? "Remote" : _state,
          "is_flagged": 0,
          "is_deleted": 0,
          "deleted_comment": null,
          "salary": _salary == 0 ? null : _salary,
          "job_type": _jobType,
          "job_category": _jobCategory,
          "winner": null,
          "competition_category": null,
          "start_date": null,
          "address": null,
          "start_time": null,
          "fee": null,
          "deadline": null,
          "is_scraped": null,
          "genre": null,
          "published_date": null,
          "hasbeenfeatured": null,
          "likecount": 0,
          "writer": null,
          "awards": null
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
