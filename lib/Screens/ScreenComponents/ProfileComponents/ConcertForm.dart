import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConcertOpportunityForm extends StatefulWidget {
  @override
  _ConcertOpportunityFormState createState() => _ConcertOpportunityFormState();
}

class _ConcertOpportunityFormState extends State<ConcertOpportunityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _organization = '';
  double _fee = 0.0;
  String _address = '';
  String _city = '';
  String _state = '';
  String _genre = 'Alternative';
  DateTime _endDate = DateTime.now();
  TimeOfDay? _startTime;
  String _link = '';
  String _description = '';

  bool _isRemote = false;

  bool _isLoading = false;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

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
          TextFormField(
            decoration: const InputDecoration(labelText: 'Organization'),
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
          /*TextFormField(
            decoration: const InputDecoration(labelText: 'Fee'),
            onSaved: (value) {
              _organization = value!;
            },
          ),*/
          TextFormField(
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (!_isRemote && (value == null || value.isEmpty)) {
                return 'Please enter an address';
              }
              return null;
            },
            enabled: !_isRemote,
            onSaved: (value) {
              _address = value!;
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
            onSaved: (value) {
              _city = value!;
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
            onSaved: (value) {
              _state = value!;
            },
          ),
          CheckboxListTile(
            title: Text('Remote'),
            value: _isRemote,
            onChanged: (value) {
              setState(() {
                _isRemote = value!;
              });
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
          InkWell(
            onTap: () {
              _selectTime(context);
            },
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Start Time',
                hintText: 'Select start time',
              ),
              child: _startTime == null
                  ? Text('')
                  : Text(
                '${_startTime!.hour}:${_startTime!.minute}',
              ),
            ),
          ),

          TextFormField(
            decoration: const InputDecoration(labelText: 'Date'),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                setState(() {
                  _endDate = selectedDate;
                });
              }
            },
            readOnly: true,
            controller: TextEditingController(text: '${_endDate.toLocal()}'.split(' ')[0]),
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
                submitConcertPost();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> submitConcertPost() async {
    // Here you can submit the job post to your API
    // Construct the job post object using the form data
    // Send a POST request to your API endpoint with the job post data
    print('Submitting job post...');
    print('Title: $_title');
    print('Organization: $_organization');
    print('Address: $_address');
    print('City: $_city');
    print('State: $_state');
    print('Deadline: $_startTime');
    print('Deadline: $_endDate');
    print('Link: $_link');
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
