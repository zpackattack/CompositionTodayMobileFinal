import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class festival extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:SizedBox(
        width: 336,
        height: 114,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 336,
                height: 114,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF4E4E4E)),
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 17,
              top: 20,
              child: SizedBox(
                width: 248,
                height: 41,
                child: Text(
                  "Jerome's Laneway Festival",
                  style: TextStyle(
                    color: Color(0xFF228BE6),
                    fontSize: 20,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Positioned(
              left: 16,
              top: 50,
              child: SizedBox(
                width: 180,
                height: 23,
                child: Text(
                  'Fans of death metal',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Positioned(
              left: 16,
              top: 74,
              child: SizedBox(
                width: 202,
                height: 19,
                child: Text(
                  'Jan 1, 2024 - Jan 4, 2024',
                  style: TextStyle(
                    color: Color(0xFF464444),
                    fontSize: 16,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 220,
              top: 49,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.money_dollar, // You can replace this with your desired icon
                    color: Colors.green,
                    size: 23,
                  ),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 80,
                    height: 17,
                    child: Text(
                      'FREE',
                      style: TextStyle(
                        color: Color(0xFF333232),
                        fontSize: 14,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 242,
              top: 74,
              child: Row(
                  children: [

                    SizedBox(width: 4), // Add some spacing between the icon and text
                    SizedBox(
                      width: 83,
                      height: 50,
                      child: Text(
                        'Pitsburg, Pennsilvania',
                        style: TextStyle(
                          color: Color(0xFF333232),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]
              ),
            ),
        const Positioned(
          left: 220,
          top: 74,
          child: Icon(
            Icons.location_pin, // You can replace this with your desired icon
            color: Colors.green,
            size: 20,
          ),
        )
          ],
        ),
      ),
    );
  }
}