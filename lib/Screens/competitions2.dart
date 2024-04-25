import 'dart:io';

import 'package:compositiontodaymobile1/Screens/ScreenComponents/CompetitionComponents/competition.dart';
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

import 'ScreenComponents/CompetitionComponents/CompetitionDescription.dart';
import 'ScreenComponents/CompetitionComponents/CompetitionState.dart';
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
class Competitions2 extends StatefulWidget {
  const Competitions2({super.key});

  @override
  _CompetitionsState createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions2> {
  late Future<List<CompetitionData1>> futureCompetitions;

  @override
  void initState() {
    super.initState();
    futureCompetitions = fetchCompetitions();
  }

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
                title: Row(
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
                        final url = Uri.parse('https://compositiontoday.net/#/compositions');
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
                          fontSize: screenHeight * 0.018
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
                  child: FutureBuilder<List<CompetitionData1>>(
                    future: futureCompetitions,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No competitions available.',
                            style: TextStyle(
                            color: Color(0xFF228BE6),
                          fontSize: 20,
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
                            final competitionData = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                            onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => CompetitionDescription(data: competitionData),
                            ),
                            );
                            },
                              child: Competition(
                                competitionTitle: competitionData.title,
                                competitionOrganization: competitionData.organization,
                                competitionDate: competitionData.date,
                                competitionType: competitionData.type,
                                competitionStatus: competitionData.status,
                                competitionPrice: competitionData.fee,
                                competitionCategory: competitionData.category,
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
  Future<List<CompetitionData1>> fetchCompetitions() async {
    try {
      final countResponse = await http.get(Uri.parse(
          'https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/competitions/count'));

      var countData = json.decode(countResponse.body)['count'];

      var count = (countData / 10).ceil();
      print(count);
      final List<CompetitionData1> CompetitionDataList = [];

      for (var c = 1; c <= count && c <= 3; c++) {
        final response = await http.get(Uri.parse(
            'https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/competitions?page_number=$c'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['listOfObjects'];



          for (var i = 0; i < data.length; i++) {
            final entry = data[i];
            CompetitionDataList.add(CompetitionData1.fromJson(entry));
          }
          print(CompetitionDataList.length);


        } else if (response.statusCode == 504) {
          print("Not in 504");
          throw Exception('Failed to load data');
        } else {
          print("Not in");
          throw Exception('Failed to load data');
        }
      }
      return CompetitionDataList;
      // Return an empty list if no data is found
      return [];
    } catch (error) {
      print("Error: $error");
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }
        }

class CompetitionData1 {
  final String title;
  final String organization;
  final String description;
  final String date;
  final String type;
  final String status;
  final String fee;
  final String link;
  final String city;
  final String state;
  final String category;
  final DateTime time;

  CompetitionData1({
    required this.title,
    required this.organization,
    required this.description,
    required this.date,
    required this.type,
    required this.status,
    required this.fee,
    required this.link,
    required this.city,
    required this.state,
    required this.category,
    required this.time,
  });

  factory CompetitionData1.fromJson(Map<String, dynamic> json) {
    DateTime date = _parseDate(json['end_date']);

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

    String price;
    if (json['fee'] != null && json['fee'] != 0) {
      // If price is not null and not equal to 0, use the value as is
      price = json['fee'].toString();
    } else if (json['fee'] != null && json['fee'] == 0) {
      // If price is null or equal to 0, set it to "FREE"
      price = 'FREE';
    }
    else{
      price = 'Not Found';
    }

    return CompetitionData1(
      title: json['title'] ?? '',
      organization: json['organization'] ?? '',
      description: json['description'] ?? '',
      date: formatDate(date),
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      fee: price,
      link: json['link'] ?? '',
      city: city,
      state: json['state'] != null && json['state'] != "Remote" ? json['state'].toString() : '',
      category: json['competition_category'] ?? '',
      time: date
    );
  }

}


DateTime _parseDate(dynamic timestamp) {
  if (timestamp is int) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  } else if (timestamp is String) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
  } else {
    return DateTime.now();
  }
}
String formatDate(DateTime date) {
  return DateFormat('MMM d, yyyy').format(date);
}