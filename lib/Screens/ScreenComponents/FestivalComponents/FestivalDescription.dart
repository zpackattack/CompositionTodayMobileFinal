import 'dart:io';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:compositiontodaymobile1/Screens/ScreenComponents/FestivalComponents/FestivalState.dart';
import 'package:compositiontodaymobile1/Screens/ScreenComponents/FestivalComponents/FestivalState.dart';
import 'package:compositiontodaymobile1/Screens/ScreenComponents/FestivalComponents/FestivalState.dart';
import 'package:compositiontodaymobile1/Screens/competitions2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../Concerts1.dart';
import '../../Festivals1.dart';


class FestivalDescription extends StatelessWidget {
  final FestivalData data;

  const FestivalDescription({Key? key, required this.data});

  //make calendar even to span the entirety of the festival
  Event buildEventSpan({Recurrence? recurrence}) {
    return Event(
      title: data.title,
      description: data.description,
      location: '${data.city} ${data.state}',
      startDate: data.startTime,
      endDate: data.endTime,
      allDay: true,
      iosParams: const IOSParams(
      ),
      androidParams: const AndroidParams(

      ),
      recurrence: recurrence,
    );
  }

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: '${data.title} Application Deadline',
      description: data.description,
      location: '${data.city} ${data.state}',
      startDate: data.time,
      endDate: data.time,
      allDay: true,
      iosParams: const IOSParams(
      ),
      androidParams: const AndroidParams(

      ),
      recurrence: recurrence,
    );
  }

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
                data.org,
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: screenHeight * 0.034,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.04 * screenHeight),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.green,
                    size: screenHeight * 0.035,
                  ),
                  SizedBox(width: 0.01 * screenWidth),
                  Text(
                    '${data.city} ${data.state}',
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: screenHeight * 0.027,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.016 * screenHeight),
              GestureDetector(
                onTap: () {
                  Add2Calendar.addEvent2Cal(
                    buildEventSpan(),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.green,
                      size: screenHeight * 0.035,
                    ),
                    SizedBox(width: 0.01 * screenWidth),
                    Text(
                      '${data.start} - ${data.end}',
                      style: TextStyle(
                        color: Color(0xFF454545),
                        fontSize: screenHeight * 0.027,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.016 * screenHeight),
              GestureDetector(
                onTap: () {
                  Add2Calendar.addEvent2Cal(
                    buildEvent(),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.alarm,
                      color: Colors.green,
                      size: screenHeight * 0.035,
                    ),
                    SizedBox(width: 0.01 * screenWidth),
                    Text(
                      data.deadline,
                      style: TextStyle(
                        color: Color(0xFF454545),
                        fontSize: screenHeight * 0.027,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.04 * screenHeight),
              Center(
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00A550), Color(0xFF228BE6)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final url = Uri.parse(data.link);
                      if (await canLaunchUrl(url)) {
                        if (Platform.isIOS) {
                          launchUrl(url, mode: LaunchMode.inAppBrowserView);
                        } else {
                          launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ), // Adjust Rect dimensions as needed
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: screenWidth * 0.4, minHeight: screenHeight*0.025),
                      alignment: Alignment.center,
                      child: Text(
                        "More Info",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 0.05 * screenWidth,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.06 * screenHeight),
              Text(
                'Description:',
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: screenHeight * 0.033,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.016 * screenHeight),
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