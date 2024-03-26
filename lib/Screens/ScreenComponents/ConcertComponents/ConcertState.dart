import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Concert extends StatelessWidget {
  final String ConcertTitle;
  final String ConcertOrganization;
  final String Date;
  final String ConcertCity;
  final String ConcertState;

  const Concert({
    required this.ConcertTitle,
    required this.ConcertOrganization,
    required this.Date,
    required this.ConcertCity,
    required this.ConcertState,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate proportional size based on screen size
    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenHeight * 0.15;

    // Calculate proportional positions based on screen size
    final titleLeft = cardWidth * 0.05;
    final titleTop = cardHeight * 0.18;
    final organizationLeft = cardWidth * 0.05;
    final organizationTop = cardHeight * 0.44;
    final dateLeft = cardWidth * 0.05;
    final dateTop = cardHeight * 0.65;
    final locationLeft = cardWidth * 0.72;
    final locationTop = cardHeight * 0.44;
    final iconLeft = cardWidth * 0.67;
    final iconTop = cardHeight * 0.42;

    return Center(
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
                    side: const BorderSide(width: 1, color: Color(0xFF4E4E4E)),
                    borderRadius: BorderRadius.circular(cardHeight * 0.24),
                  ),
                ),
              ),
            ),
            Positioned(
              left: titleLeft,
              top: titleTop,
              child: SizedBox(
                width: cardWidth * 0.9,
                height: cardHeight * 0.22,
                child: Text(
                  ConcertTitle,
                  style: TextStyle(
                    color: Color(0xFF228BE6),
                    fontSize: cardHeight * 0.17,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              left: organizationLeft,
              top: organizationTop,
              child: SizedBox(
                width: cardWidth * 0.6,
                height: cardHeight * 0.15,
                child: Text(
                  ConcertOrganization,
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
            Positioned(
              left: dateLeft,
              top: dateTop,
              child: SizedBox(
                width: cardWidth * 0.9,
                height: cardHeight * 0.16,
                child: Text(
                  Date,
                  style: TextStyle(
                    color: Color(0xFF464444),
                    fontSize: cardHeight * 0.12,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: locationLeft,
              top: locationTop,
              child: Row(
                children: [
                  SizedBox(width: cardWidth * 0.02), // Add some spacing between the icon and text
                  SizedBox(
                    width: cardWidth * 0.23,
                    height: cardHeight * 0.4,
                    child: Text(
                      '$ConcertCity $ConcertState',
                      style: TextStyle(
                        color: Color(0xFF333232),
                        fontSize: cardHeight * 0.12,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: iconLeft,
              top: iconTop,
              child: Icon(
                Icons.location_pin, // You can replace this with your desired icon
                color: Colors.green,
                size: cardHeight * 0.17,
              ),
            )
          ],
        ),
      ),
    );
  }
}
