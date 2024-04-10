import 'dart:convert';
import 'dart:io';

import 'package:compositiontodaymobile1/Screens/ScreenComponents/HomeComponents/BlogDescription.dart';
import 'package:compositiontodaymobile1/Screens/profile.dart';
import 'package:compositiontodaymobile1/Screens/profileAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ScreenComponents/HomeComponents/FeaturedComposition.dart';
import 'ScreenComponents/HomeComponents/Newsfeed.dart';
import 'ScreenComponents/HomeComponents/Blog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
//import '../../assets/img/BigMusicNote.png';
import 'headers.dart';

class AuthenticationWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator if authentication state is not yet determined
          return CircularProgressIndicator();
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


class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);
  static const route = '/homeScreen';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                title: Align(
                  alignment: Alignment.bottomCenter,


                  child: Row(
                  children: <Widget>[

                    // Left aligned

                    ClipRect(
                      child: Expanded(
                      child:Padding(
                      padding: Platform.isIOS ? EdgeInsets.symmetric(horizontal: screenWidth * 0.03) : EdgeInsets.only(left: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'COMPOSITION:',
                                  style: TextStyle(
                                    color: Color(0xFF454545),
                                    fontSize: screenHeight * 0.018,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: 'TODAY',
                                  style: TextStyle(
                                    color: Color(0xFF228BE6),
                                    fontSize: screenHeight * 0.018,
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
                    // Right aligned
                    ClipRect(
                      child:Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          // Profile Icon
                          IconButton(
                            icon: Icon(Icons.account_circle, size: screenHeight * 0.03),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
                              );
                            },
                          ),
                          // Dropdown menu for login/register

                        ],
                      ),
                    ),
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
              expandedHeight: screenHeight*0.068,
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF00A550), Color(0xFF228BE6)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final url = Uri.parse('http://compositiontoday.net');
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
                      ),
                      child: Container(
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

            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title for Featured Compositions
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth*0.05),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'FEATURED:',
                                  style: TextStyle(
                                    color: Color(0xFF454545),
                                    fontSize: screenHeight * 0.022,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'COMPOSITION',
                                  style: TextStyle(
                                    color: Color(0xFF228BE6),
                                    fontSize: screenHeight * 0.022,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: 10),
                        Stack( // Wrap the Positioned and FeaturedComposition with a Stack
                          children: [
                            // Featured Composition Section
                            FutureBuilder<List<FeaturedCompositionData>>(
                              future: fetchComps(),
                              builder: (context, snapshot) {
                                // Build Featured Composition section
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return const Center(child: Text('No compositions available. Check back soon for more!',
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
                                  return Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child:SizedBox(
                                    height: screenHeight*0.18, // Adjust the height as needed
                                    child:ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: snapshot.data!.map((compData) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                                          child: FeaturedComposition(
                                              data:compData
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight*0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title for Newsfeed
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth*0.06),
                          child: Row(
                            children: [
                            Text(
                            'NEWSFEED:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF454545),
                                fontSize: screenHeight * 0.022,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),

                            Icon(
                              Icons.newspaper_rounded, // You can replace this with your desired icon
                              color: Colors.green,
                              size: screenHeight * 0.03,
                            ),
                          ],
                        ),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder<NewsfeedData?>(
                          future: fetchLatestNewsfeed(),
                          builder: (context, snapshot) {
                            // Build Newsfeed section
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loading indicator while fetching data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final latestNewsfeedData = snapshot.data;
                              if (latestNewsfeedData != null) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Newsfeed(
                                          link: latestNewsfeedData.link,
                                          title: latestNewsfeedData.title,
                                          organization: latestNewsfeedData.organization,
                                          writer: latestNewsfeedData.writer,
                                        ),
                                        SizedBox(height: screenHeight*0.03),
                                        SizedBox(

                                          height: screenHeight*0.06,
                                          width: screenWidth * 0.6,
                                          child: Ink(
                                          decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                          colors: [Color(0xFF00A550), Color(0xFF228BE6)],
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                          ),
                                          child: ElevatedButton(
                                          onPressed: () async {
                                            final url = Uri.parse('http://compositiontoday.net/#/news');
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
                                            ),
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                  "See More",
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
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Column(
                                    children: [
                                      Newsfeed(
                                        link: '',
                                        title: 'No newsfeed data available',
                                        organization: '',
                                        writer: '',
                                      ),
                                      SizedBox(height: screenHeight*0.03),
                                      SizedBox(

                                        height: screenHeight*0.06,
                                        width: screenWidth * 0.6,
                                        child: Ink(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFF00A550), Color(0xFF228BE6)],
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final url = Uri.parse('http://compositiontoday.net/#/news');
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
                                            ),
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "See More",
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
                                    ],
                                  ),
                                );



                              }
                            }
                          },
                        ),
      ],
                    ),
    ),


                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight*0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title for Blog
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth*0.06),
                          child: Row(
                            children: [
                              Text(
                                'BLOG:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF454545),
                                  fontSize: screenHeight * 0.022,
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),

                              Icon(
                                Icons.note_alt_outlined, // You can replace this with your desired icon
                                color: Colors.green,
                                size: screenHeight * 0.024,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        FutureBuilder<BlogData?>(
                          future: fetchLatestBlog(),
                          builder: (context, snapshot) {
                            // Build Newsfeed section
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loading indicator while fetching data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final latestBlogfeedData = snapshot.data;
                              if (latestBlogfeedData != null) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                          builder: (context) => BlogDescription(data: latestBlogfeedData),
                                          ),
                                          );
                                          },
                                        child:Blog(
                                          date_posted: latestBlogfeedData.date_posted,
                                          title: latestBlogfeedData.title,
                                          organization: latestBlogfeedData.organization,
                                          description: latestBlogfeedData.description,
                                        ),
                                        ),
                                        SizedBox(height: screenHeight*0.03),
                                        SizedBox(

                                          height: screenHeight*0.06,
                                          width: screenWidth * 0.6,
                                          child: Ink(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [Color(0xFF00A550), Color(0xFF228BE6)],
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                final url = Uri.parse('https://compositiontoday.net/#/blog');
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
                                              ),
                                              child: Container(
                                                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "See More",
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
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Column(
                                    children: [
                                      Blog(
                                          date_posted: '',
                                          title: 'No blog posts yet',
                                          organization: '',
                                          description: ''
                                      ),
                                      SizedBox(height: screenHeight*0.03),
                                      SizedBox(

                                        height: screenHeight*0.06,
                                        width: screenWidth * 0.6,
                                        child: Ink(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFF00A550), Color(0xFF228BE6)],
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final url = Uri.parse('http://compositiontoday.net/#/blog');
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
                                            ),
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "See More",
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
                                    ],
                                  ),
                                );



                              }
                            }
                          },
                        ),
                        SizedBox(height: screenHeight*0.09)
                      ],

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showPopupMenu(BuildContext context, Offset tapPosition) {
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        tapPosition,
        tapPosition.translate(0.0, 0.0), // Adjust if needed
      ),
      Offset.zero & overlay.size,
    );
    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: Text("Login"),
          value: "login",
        ),
        PopupMenuItem(
          child: Text("Register"),
          value: "register",
        ),
      ],
    );
  }
}


//Fetch newsfeed data
Future<NewsfeedData?> fetchLatestNewsfeed() async {
  try {
    final response = await http.get(Uri.parse('https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/news?page_number=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['listOfObjects'];

      if (data.isNotEmpty) {
        // Get the latest newsfeed data
        final latestEntry = data[0];
        return NewsfeedData.fromJson(latestEntry);
      } else {
        return null; // Return null if there are no newsfeed entries
      }
    } else if (response.statusCode == 504) {
      throw Exception('Failed to load data');
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print("Error: $error");
    throw error; // Rethrow the error to be caught by the FutureBuilder
  }
}
//End Fetch newsfeed data


//Fetch blog data
Future<BlogData?> fetchLatestBlog() async {
  try {
    final response = await http.get(Uri.parse('https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/blog?page_number=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['listOfObjects'];

      if (data.isNotEmpty) {
        // Get the latest newsfeed data
        final latestEntry = data[0];
        return BlogData.fromJson(latestEntry);
      } else {
        return null; // Return null if there are no newsfeed entries
      }
    } else if (response.statusCode == 504) {
      throw Exception('Failed to load data');
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print("Error: $error");
    throw error; // Rethrow the error to be caught by the FutureBuilder
  }
}
//End Fetch blog data

Future<List<FeaturedCompositionData>> fetchComps() async {
  try {
    final response = await http.get(Uri.parse(
    'https://oyster-app-7l5vz.ondigitalocean.app/compositiontoday/featuredcompositions'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['listOfObjects'];

      final List<FeaturedCompositionData> concertDataList = [];

      for (var i = 0; i < data.length ; i++) {
        final entry = data[i];
        concertDataList.add(FeaturedCompositionData.fromJson(entry));
      }

      return concertDataList;

    } else if (response.statusCode == 504) {
      print("Not in 504");
      throw Exception('Failed to load data');
    } else {
      print("Not in");
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print("Error: $error");
    throw error; // Rethrow the error to be caught by the FutureBuilder
  }
}


//Store FeaturedCompositionData
class FeaturedCompositionData {
  final String title;
  final String fname;
  final String lname;
  final String link;
  final String description;
  final String genre;

  FeaturedCompositionData({
    required this.title,
    required this.fname,
    required this.lname,
    required this.link,
    required this.description,
    required this.genre,
  });

  factory FeaturedCompositionData.fromJson(Map<String, dynamic> json) {
    return FeaturedCompositionData(
        title: json['title'] ?? '',
        fname: json['first_name'] ?? '',
        lname: json['last_name'] ?? '',
        link: json['link'] ?? '',
        description: json['description'] ?? '',
        genre: json['genre'] ?? ''
    );
  }
}
//End Store FeaturedCompositionData


//Store Newsfeed Data
class NewsfeedData {
  final String title;
  final String organization;
  final String link;
  final String description;
  final String writer;

  NewsfeedData({
    required this.title,
    required this.organization,
    required this.link,
    required this.description,
    required this.writer,
  });

  factory NewsfeedData.fromJson(Map<String, dynamic> json) {
    return NewsfeedData(
      title: json['title'] ?? '',
      organization: json['organization'] ?? '',
      link: json['link'] ?? '',
      description: json['description'] ?? '',
      writer: json['writer'] ?? '',
    );
  }
}
//End Store Newsfeed Data

//Store Blog Data
class BlogData {
  final String title;
  final String organization;
  final String date_posted;
  final String description;

  BlogData({
    required this.title,
    required this.organization,
    required this.date_posted,
    required this.description,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(json['date_posted']);
    String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);

    String org = json['organization'] ?? '';

    if (org.toLowerCase().startsWith("posted by:")) {
      // Extract the part after "posted by:"
      org = org.substring("posted by:".length).trim();
    }

    return BlogData(
      title: json['title'] ?? '',
      organization: org,
      date_posted: formattedDate ?? '',
      description: json['description'] ?? '',
    );
  }
}
//End Store Blog Data
