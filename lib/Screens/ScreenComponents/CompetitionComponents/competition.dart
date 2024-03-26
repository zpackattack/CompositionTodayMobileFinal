import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class competition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:SizedBox(
          width: 336,
          height: 120,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 336,
                  height: 120,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF4E4E4E)),
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 17,
                top: 14,
                child: SizedBox(
                  width: 248,
                  height: 45,
                  child: Text(
                    'VIENNA INTERNATIONAL MUSIC COMPETITION',
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
                left: 17,
                top: 64,
                child: SizedBox(
                  width: 180,
                  height: 23,
                  child: Text(
                    'VIENNA COMPETITION',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 17,
                top: 84,
                child: SizedBox(
                  width: 132,
                  height: 19,
                  child: Text(
                    'MAR, 23, 2024',
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
                top: 80,
                child: SizedBox(
                  width: 80,
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(
                    CupertinoIcons.money_dollar, // You can replace this with your desired icon
                    color: Colors.green,
                    size: 23,
                  ),
                  //SizedBox(width: 4),
                  Text(
                    'FREE',
                    style: TextStyle(
                      color: Color(0xFF333232),
                      fontSize: 14,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  ]
                ),
              ),
              ),
            ],
          ),
        )
    );
  }
}