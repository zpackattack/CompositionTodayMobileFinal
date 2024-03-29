import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'ScreenComponents/ConcertComponents/ConcertDescription.dart';
import 'ScreenComponents/ConcertComponents/ConcertState.dart';

class Concerts extends StatelessWidget {
  const Concerts({Key? key});

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
              expandedHeight: 100.0, // Adjust the height as needed
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: Platform.isIOS ? MainAxisAlignment.center : MainAxisAlignment.start, //Fixes bug where title is left aligned on iOS
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'COMPOSITION:',
                              style: TextStyle(
                                color: Color(0xFF454545),
                                fontSize: Platform.isIOS ? screenHeight * 0.02 : 16,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'TODAY',
                              style: TextStyle(
                                color: Color(0xFF228BE6),
                                fontSize: Platform.isIOS ? screenHeight * 0.02 : 16,
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
                    ],
                  ),
                ),
              ),
            ),
            //End Header

            //Start Open in browser button
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 52.0,
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
                        final url = Uri.parse('https://compositiontoday.net/#/concerts');
                        if (await canLaunchUrl(url)) {
                          launchUrl(url, mode: LaunchMode.externalApplication);
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
              child: FutureBuilder<List<ConcertData>>(
                future: fetchConcerts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No concerts available.',
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
                        final concertData = snapshot.data![index];
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child:GestureDetector(
                        onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => ConcertDescription(data: concertData),
                        ),
                        );
                        },
                        child: Concert(
                            // Pass concert data to the Concert widget
                            ConcertTitle: concertData.title,
                            ConcertOrganization: concertData.org,
                            Date: concertData.date,
                            ConcertCity: concertData.city,
                            ConcertState: concertData.state,
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

  Future<List<ConcertData>> fetchConcerts() async {
    try {
      final countResponse = await http.get(Uri.parse(
          'https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/concerts/count'));

      var countData = json.decode(countResponse.body)['count'];

      var count = (countData / 10).ceil();
      print(count);
      final List<ConcertData> concertDataList = [];

      for (var c = 1; c <= count && c <= 3; c++) {
        final response = await http.get(Uri.parse(
            'https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/concerts?page_number=$c'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['listOfObjects'];



          for (var i = 0; i < data.length; i++) {
            final entry = data[i];
            concertDataList.add(ConcertData.fromJson(entry));
          }
          print(concertDataList.length);


        } else if (response.statusCode == 504) {
          print("Not in 504");
          throw Exception('Failed to load data');
        } else {
          print("Not in");
          throw Exception('Failed to load data');
        }
      }
      return concertDataList;
      // Return an empty list if no data is found
      return [];
    } catch (error) {
      print("Error: $error");
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }
}

class ConcertData {
  final String title;
  final String org;
  final String date;
  final String city;
  final String state;
  final String description;
  final String link;
  final String address;
  final String startTime;
  final DateTime time;

  ConcertData({
    required this.title,
    required this.org,
    required this.date,
    required this.city,
    required this.state,
    required this.description,
    required this.link,
    required this.address,
    required this.startTime,
    required this.time,
  });

  factory ConcertData.fromJson(Map<String, dynamic> json) {

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

    DateTime date = _parseDate(json['end_date']);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(json['start_time']);
    DateTime time = _parseDate(json['end_date']);
    String formattedTime = "${dateTime.hour > 12 ? dateTime.hour-12 : dateTime.hour == 0 ? 12 : dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}";

    return ConcertData(
      title: json['title'] ?? '',
      org: json['organization'] ?? '',
      date: formatDate(date),
      city: city,
      state: json['state'] != null && json['state'] != "Remote" ? json['state'].toString() : '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      address: json['address'] ?? '',
      startTime: formattedTime,
      time: time,
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