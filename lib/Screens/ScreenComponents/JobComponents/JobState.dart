import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Job extends StatelessWidget {
  final String JobTitle;
  final String JobOrganization;
  final String JobType;
  final String JobCity;
  final String JobState;
  final String Salary;
  final String Category;

  const Job({
    required this.JobTitle,
    required this.JobOrganization,
    required this.JobType,
    required this.JobCity,
    required this.JobState,
    required this.Salary,
    required this.Category,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate proportional size based on screen size
    final cardWidth = screenWidth * 0.9;
    final cardHeight = screenHeight * 0.2;

    // Calculate proportional positions based on screen size
    final titleLeft = cardWidth * 0.05;
    final titleTop = cardHeight * 0.1167;
    final jobTypeLeft = cardWidth * 0.05;
    final jobTypeTop = cardHeight * 0.5;
    final organizationLeft = cardWidth * 0.05;
    final organizationTop = cardHeight * 0.5;
    final locationLeft = cardWidth * 0.05;
    final locationTop = cardHeight * 0.75;
    final iconLeft = cardWidth * 0.58;
    final iconTop = cardHeight * 0.23;
    final textLeft = cardWidth * 0.65;// Adjusted to provide spacing between icon and text

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
                    borderRadius: BorderRadius.circular(cardHeight * 0.18),
                  ),
                ),
              ),
            ),
            Positioned(
              left: titleLeft,
              top: titleTop,
              child: SizedBox(
                width: cardWidth * 0.9,
                height: cardHeight * 0.3,
                child: Text(
                  JobTitle,
                  style: TextStyle(
                    color: Color(0xFF228BE6),
                    fontSize: cardHeight * 0.13,
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
                width: cardWidth * 0.5,
                height: cardHeight * 0.18,
                child: Text(
                  JobOrganization,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: cardHeight * 0.09,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              left: locationLeft,
              top: locationTop,
              child: SizedBox(
                width: cardWidth * 0.5,
                height: cardHeight * 0.18,
                child: Text(
                  '$JobCity $JobState',
                  style: TextStyle(
                    color: Color(0xFF464444),
                    fontSize: cardHeight * 0.09,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              left: textLeft,
              top: organizationTop,

              child:SizedBox(
                width: cardWidth * 0.3,
                height: cardHeight * 0.2,
                child: Text(
                  JobType,
                  style: TextStyle(
                    color: Color(0xFF333232),
                    fontSize: cardHeight * 0.09,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),


            ),
            Positioned(
              left: iconLeft,
              top: organizationTop,
              child: Icon(
                Icons.work,
                color: Colors.green,
                size: cardHeight * 0.1,
              ),
            ),
            Positioned(
              left: iconLeft,
              top: locationTop,
              child: Icon(
                Icons.category,
                color: Colors.green,
                size: cardHeight * 0.1,
              ),
            ),
            Positioned(
              left: textLeft,
              top: locationTop,
              child: SizedBox(
                width: cardWidth * 0.3,
                height: cardHeight * 0.2,
                child: Text(
                  Category,
                  style: TextStyle(
                    color: Color(0xFF333232),
                    fontSize: cardHeight * 0.09,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  maxLines: 2,
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
