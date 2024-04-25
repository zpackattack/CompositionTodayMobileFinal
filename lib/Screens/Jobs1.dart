import 'dart:io';

import 'package:compositiontodaymobile1/Screens/ScreenComponents/JobComponents/JobDescription.dart';
import 'package:compositiontodaymobile1/Screens/profile.dart';
import 'package:compositiontodaymobile1/Screens/profileAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'ScreenComponents/JobComponents/JobState.dart';
import 'home.dart';

class AuthenticationWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator if authentication state is not yet determined
          return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
        } else if (snapshot.hasData) {
          // User is signed in, navigate to home screen
          return UserInfoPage(user: snapshot.data!);
        } else {
          // No user is signed in, navigate to login/register screen
          return ProfilePage();
        }
      },
    );
  }
}

class Jobs extends StatelessWidget {
  const Jobs({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 250),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            //Start Header
            SliverAppBar(
              pinned: true,
              expandedHeight: 108.0, // Adjust the height as needed
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: screenWidth*0.06),
                title: /*Align(
                  alignment: Alignment.bottomCenter,


                  child: Row(
                    children: <Widget>[

                      // Left aligned

                      ClipRect(
                        child: Expanded(
                          child:Padding(
                            padding: Platform.isIOS ? EdgeInsets.symmetric(horizontal: screenWidth * 0.03) : EdgeInsets.only(left: 0),
                            child: */
                              Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'COMPOSITION:',
                                        style: TextStyle(
                                          color: Color(0xFF454545),
                                          fontSize: screenHeight * 0.019,
                                          fontFamily: 'SF Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'TODAY',
                                        style: TextStyle(
                                          color: Color(0xFF228BE6),
                                          fontSize: screenHeight * 0.019,
                                          fontFamily: 'SF Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Logo
                                Image.asset(
                                  'lib/assets/img/MusicNote.png',
                                  height: screenHeight * 0.025,
                                  width: screenHeight * 0.025,
                                  fit: BoxFit.contain,
                                ),

                                IconButton(
                                  icon: Icon(Icons.account_circle, size: screenHeight * 0.03),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                        /*),
                      ),
                      // Right aligned
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // Profile Icon

                            // Dropdown menu for login/register

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
            ),
            //End Header

            //Start Open in browser button
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: screenHeight*0.068,
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF00A550), Color(0xFF228BE6)],),
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final url = Uri.parse('https://compositiontoday.net/#/jobs');
                        if (await canLaunchUrl(url)) {
                          if (Platform.isIOS) {
                            launchUrl(url, mode: LaunchMode.inAppBrowserView);
                          } else {
                            launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ), // Adjust Rect dimensions as needed
                        //),
                      ), child: Container(
                      constraints: const BoxConstraints(maxWidth: 180.0, minHeight: 20.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Open in Browser",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.018,
                        ),
                      ),
                    ),
                    ),
                  ),
                ),
              ),
            ),
            //End Open in browser button

            SliverToBoxAdapter(
              child: FutureBuilder<List<JobData>>(
                future: fetchJobs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Jobs available. Check back soon for more!',
                        style: TextStyle(
                          color: Color(0xFF228BE6),
                          fontSize: 24,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                    ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final jobData = snapshot.data![index];
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                            onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDescription(data: jobData),
                            ),
                            );
                          },
                          child: Job(
                            // Pass concert data to the Concert widget
                            JobTitle: jobData.title,
                            JobOrganization: jobData.org,
                            JobType: jobData.jobType,
                            JobCity: jobData.city,
                            JobState: jobData.state,
                            Salary: jobData.salary,
                            Category: jobData.category,
                          ),
                        ),
                      );

                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<JobData>> fetchJobs() async {
    try {
      final countResponse = await http.get(Uri.parse(
          'https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/jobs/count'));

      var countData = json.decode(countResponse.body)['count'];

      var count = (countData / 10).ceil();
      print(count);
      final List<JobData> jobDataList = [];

      for (var c = 1; c <= count && c <= 3; c++) {
        final response = await http.get(Uri.parse(
            'https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/jobs?page_number=$c'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['listOfObjects'];



          for (var i = 0; i < data.length; i++) {
            final entry = data[i];
            jobDataList.add(JobData.fromJson(entry));
          }
          print(jobDataList.length);


        } else if (response.statusCode == 504) {
          print("Not in 504");
          throw Exception('Failed to load data');
        } else {
          print("Not in");
          throw Exception('Failed to load data');
        }
      }
      return jobDataList;
      // Return an empty list if no data is found
      return [];
    } catch (error) {
      print("Error: $error");
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }
}

class JobData {
  final String title;
  final String org;
  final String jobType;
  final String city;
  final String state;
  final String salary;
  final String description;
  final String link;
  final String category;

  JobData({
    required this.title,
    required this.org,
    required this.jobType,
    required this.city,
    required this.state,
    required this.salary,
    required this.description,
    required this.link,
    required this.category,
  });

  factory JobData.fromJson(Map<String, dynamic> json) {

    String city;
    if (json['city'] != null && json['city'] == "Remote") {
      // If price is not null and not equal to 0, use the value as is
      city = json['city'].toString();
    } else if (json['city'] != null) {
      // If price is null or equal to 0, set it to "FREE"
      city = '${json['city']},';
    }
    else{
      city = 'Not Found';
    }


    return JobData(
      title: json['title'] ?? '',
      org: json['organization'] ?? '',
      jobType: json['job_type'] ?? '',
      city: city,
      state: json['state'] != null && json['state'] != "Remote" ? json['state'].toString() : '',
      salary: json['salary'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      category: json['job_category'] ?? '',
    );
  }
}
