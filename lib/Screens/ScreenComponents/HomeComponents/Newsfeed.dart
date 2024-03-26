import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home.dart';

class Newsfeed extends StatelessWidget {
  final String link;
  final String title;
  final String organization;
  final String writer;

  const Newsfeed({
    required this.link,
    required this.title,
    required this.organization,
    required this.writer,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate proportional size based on screen size
    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenHeight * 0.15;

    // Calculate proportional positions based on screen size
    final titleLeft = cardWidth * 0.5;
    final titleTop = cardHeight * 0.1167;
    final othersTop = cardHeight - cardHeight * 0.1167;

    return SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(link); // Replace 'https://example.com' with your desired URL
                    if (await canLaunchUrl(url)) {
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
              child: Stack(
                children: [
              Positioned(
                left: 0,
                top: 0,

                child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFF4E4E4E)),
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),

              ),


              Positioned(
                left: (cardWidth-cardWidth*0.9)/2,
                top: titleTop,
                child: SizedBox(
                  width: cardWidth*0.9,
                  height: cardHeight * 0.6,
                  child:Center(
                    child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF228BE6),
                      fontSize: cardHeight * 0.17,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                  ),
                  ),
                ),
              ),
              Positioned(
                left: cardWidth*0.05,
                top: cardHeight*0.75,
                child: SizedBox(
                  width: cardWidth*0.4,
                  height: 46,
                  child: Text(
                    organization,
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: cardHeight * 0.12,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),

                    ),
                  ),
                ),
              Positioned(
                right: cardWidth*0.05,
                top: cardHeight*0.75,
                child: SizedBox(
                  width: cardWidth*0.45,
                  height: 46,
                  child: Text(
                    writer,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: cardHeight * 0.12,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              ],
              ),
              ),
              );

  }
}