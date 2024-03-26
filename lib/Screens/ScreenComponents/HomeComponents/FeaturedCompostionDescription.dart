import 'package:compositiontodaymobile1/Screens/competitions2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../home.dart';
import 'FeaturedComposition.dart'; // Changed 'Job' to 'FeaturedComposition'

class FeaturedCompositionDescription extends StatelessWidget {
  final FeaturedCompositionData data; // Changed 'JobData' to 'FeaturedCompositionData'

  const FeaturedCompositionDescription({Key? key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(""),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF228BE6)),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: const ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/img/placeholderPerson.jpeg"),
                    fit: BoxFit.fill,
                  ),
                  shape: OvalBorder(
                    side: BorderSide(width: 4, color: Colors.white),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26646464),
                      blurRadius: 20,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              ),
              SizedBox(height: 10),
              Text(
                data.title,
                style: TextStyle(
                  color: Color(0xFF228BE6),
                  fontSize: 32,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${data.fname} ${data.lname}',
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: 25,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24),

              Row(
                children: [
                  Icon(
                    Icons.category, // You can replace this with your desired icon
                    color: Colors.green,
                    size: 24,
                  ),
                  SizedBox(width: 4),
                  Text(
                    data.genre,
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: 23,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),



              SizedBox(height: 24),
              Center(
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00A550), Color(0xFF228BE6)],),
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final url = Uri.parse(data.link);
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
                      constraints: const BoxConstraints(maxWidth: 300, minHeight: 40),
                      alignment: Alignment.center,
                      child: Text(
                        data.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Description:',
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: 25,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                data.description,
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: 20,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
