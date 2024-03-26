import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home.dart';
import 'FeaturedCompostionDescription.dart';

class FeaturedComposition1 extends StatelessWidget {
  final FeaturedCompositionData data; // Changed 'JobData' to 'FeaturedComposition1Data'

  const FeaturedComposition1({Key? key, required this.data});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          width: 405, // Increased width to accommodate the shift
          height: 150,
          child: Stack(
            children: [

              Positioned(
                left: 70,
                top: 28,
                child: Container(
                  width: 70,
                  height: 70,
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
                left: 47,
                top: 113,
                child: SizedBox(
                  width: 116,
                  height: 15,
                  child: Text(
                    '${data.fname} ${data.lname}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 175,
                top: 28,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(data.link); // Replace 'https://example.com' with your desired URL
                    if (await canLaunchUrl(url)) {
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    }

                  },
                  child: Container(
                    constraints: BoxConstraints(minWidth: 0, maxWidth: 215),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xE500A550),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        data.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 225,
                top: 100,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeaturedCompositionDescription(data: data),
                      ),
                    );

                  },
                  child: Container(
                    constraints: BoxConstraints(minWidth: 0, maxWidth: 115),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xE500A550),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'More Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
