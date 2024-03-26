import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Competition extends StatelessWidget {
  final String competitionTitle;
  final String competitionOrganization;
  final String competitionDate;
  final String competitionType;
  final String competitionStatus;
  final String competitionPrice;
  final String competitionCategory;

  const Competition({
    required this.competitionTitle,
    required this.competitionOrganization,
    required this.competitionDate,
    required this.competitionType,
    required this.competitionStatus,
    required this.competitionPrice,
    required this.competitionCategory,
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
    final titleTop = cardHeight * 0.1167;
    final organizationLeft = cardWidth * 0.05;
    final organizationTop = cardHeight * 0.53;
    final dateLeft = cardWidth * 0.05;
    final dateTop = cardHeight * 0.70;
    final priceLeft = cardWidth * 0.74;
    final priceTop = cardHeight * 0.6583;
    final iconLeft = cardWidth * 0.67;
    final iconTop = cardHeight * 0.51;


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
                    side: BorderSide(width: 1, color: Color(0xFF4E4E4E)),
                    borderRadius: BorderRadius.circular(cardHeight * 0.225),
                  ),
                ),
              ),
            ),
            Positioned(
              left: titleLeft,
              top: titleTop,
              child: SizedBox(
                width: cardWidth * 0.7381,
                height: cardHeight * 0.375,
                child: Text(
                  competitionTitle,
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
                  competitionOrganization,
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
                width: cardWidth * 0.3905,
                height: cardHeight * 0.1583,
                child: Text(
                  competitionDate,
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
              left: priceLeft,
              top: organizationTop,
              child: SizedBox(
                width: cardWidth * 0.3,
                height: cardHeight * 0.3,
                child: Text(
                      competitionCategory,
                      style: TextStyle(
                        color: Color(0xFF333232),
                        fontSize: cardHeight * 0.12,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      maxLines: 2,
                    ),

              ),
            ),
            Positioned(
              left: iconLeft,
              top: iconTop,
              child: Icon(
                Icons.category, // You can replace this with your desired icon
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
