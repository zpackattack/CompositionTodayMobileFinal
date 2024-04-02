import 'package:compositiontodaymobile1/Screens/competitions2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../Jobs1.dart';
import '../../home.dart';

class BlogDescription extends StatelessWidget {
  final BlogData data;

  const BlogDescription({Key? key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF228BE6)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0.04 * screenWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  color: Color(0xFF228BE6),
                  fontSize: screenHeight * 0.038,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.02 * screenHeight),
              Text(
                data.organization,
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: screenHeight * 0.034,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.04 * screenHeight),
              Text(
                data.date_posted,
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: screenHeight * 0.03,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 0.06 * screenHeight),

              Text(
                data.description,
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: screenHeight * 0.025,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 0.2 * screenHeight),
            ],
          ),
        ),
      ),
    );
  }
}
