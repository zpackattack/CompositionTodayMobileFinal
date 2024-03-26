import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home.dart';
import 'FeaturedCompostionDescription.dart';

class FeaturedComposition extends StatelessWidget {
  final FeaturedCompositionData data; // Changed 'JobData' to 'FeaturedCompositionData'

  const FeaturedComposition({Key? key, required this.data});

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate proportional size based on screen size
    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenHeight * 0.15;

    // Calculate proportional positions based on screen size
    final titleLeft = cardWidth * 0.4;
    final titleTop = cardHeight * 0.1167;
    final organizationLeft = cardWidth * 0.4;
    final organizationTop = cardHeight * 0.53;
    final profileLeft = cardWidth * 0.05;
    final profileTop = (cardHeight - cardHeight * 0.8) / 2;
    final priceLeft = cardWidth * 0.65;
    final priceTop = cardHeight * 0.6583;

    return GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeaturedCompositionDescription(data: data),
        ),
      );

    },
    child: SizedBox(
        width: cardWidth,
        height: cardHeight,
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
                    side: BorderSide(width: 1, color: Color(0xFF4E4E4E)),
                    borderRadius: BorderRadius.circular(cardHeight * 0.225),
                  ),
                ),
              ),
            ),
            Positioned(
              left: profileLeft,
              top: profileTop,
              child: Container(
                width: cardHeight*0.8,
                height: cardHeight*0.8,
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
            Positioned(
              left: titleLeft,
              top: titleTop,
              child: SizedBox(
                width: cardWidth * 0.6,
                height: cardHeight * 0.375,
                child: Text(
                  data.title,
                  style: TextStyle(
                    color: Color(0xFF228BE6),
                    fontSize: cardHeight * 0.17,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              left: organizationLeft,
              top: organizationTop,
              child: SizedBox(
                width: cardWidth * 0.5952,
                height: cardHeight * 0.3,
                child: Text(
                  '${data.fname} ${data.lname}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: cardHeight * 0.12,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
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
