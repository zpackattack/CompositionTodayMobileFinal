import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class headers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 298,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 50,
            child: Container(
              width: 236,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF00A550), Color(0xFF3D92A5)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Open in browser',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 259,
            top: 0,
            child: Container(
              width: 39,
              height: 39,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/39x39"),
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
            left: 0,
            top: 0,
            child: Container(
              width: 236,
              height: 39,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/236x39"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}