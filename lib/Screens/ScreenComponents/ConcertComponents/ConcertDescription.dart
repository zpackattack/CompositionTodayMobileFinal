import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:compositiontodaymobile1/Screens/competitions2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../Concerts1.dart';


class ConcertDescription extends StatelessWidget {
  final ConcertData data;

  const ConcertDescription({Key? key, required this.data});


  //Create Calendar Event
  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: data.title,
      description: data.description,
      location: data.org,
      startDate: data.time,
      endDate: data.time,
      allDay: false,
      iosParams: const IOSParams(
      ),
      androidParams: const AndroidParams(

      ),
      recurrence: recurrence,
    );
  }

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
        GestureDetector(
          onTap: () {
            MapsLauncher.launchQuery(
                data.address);
          },
          child: Text(
              data.org,
              style: TextStyle(
                color: Color(0xFF454545),
                fontSize: 25,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w600,
              ),
            ),
        ),
            SizedBox(height: 24),

            Row(
              children: [
                Icon(
                  Icons.location_pin, // You can replace this with your desired icon
                  color: Colors.green,
                  size: 23,
                ),
                SizedBox(width: 4),
                Text(
                 '${data.city} ${data.state}',
                  style: TextStyle(
                    color: Color(0xFF454545),
                    fontSize: 23,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  Icons.map_rounded, // You can replace this with your desired icon
                  color: Colors.green,
                  size: 23,
                ),
                SizedBox(width: 4),
                GestureDetector(
                onTap: () {
                  MapsLauncher.launchQuery(
                      data.address);
                },
                child: Text(
                  data.address,
                  style: TextStyle(
                    color: Color(0xFF454545),
                    fontSize: 23,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ),
              ],
            ),
            SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Add2Calendar.addEvent2Cal(
                buildEvent(),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded, // You can replace this with your desired icon
                  color: Colors.green,
                  size: 23,
                ),
              SizedBox(width: 4),
              Text(
                data.date,
                style: TextStyle(
                  color: Color(0xFF454545),
                  fontSize: 23,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              ],
            ),
          ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  CupertinoIcons.clock, // You can replace this with your desired icon
                  color: Colors.green,
                  size: 26,
                ),
                SizedBox(width: 4),
                Text(
                  data.startTime,
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
                  constraints: const BoxConstraints(maxWidth: 100, minHeight: 25),
                  alignment: Alignment.center,
                  child: const Text(
                    "More Info",
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

