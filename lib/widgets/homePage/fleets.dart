
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dealership/data/cars.dart';

import 'car.dart';
import 'category.dart';

Widget buildFleets(Size size, bool isDarkMode) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.015,
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        child: Text('Fleets',
            style:GoogleFonts.poppins(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: size.width * 0.06,
          fontWeight: FontWeight.bold,)),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.015,
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        child: SizedBox(
          height: size.width * 0.55,
          width: cars.length * size.width * 0.5 * 1.03,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: cars.length,
            itemBuilder: (context, i) {
              return buildCar(
                i,
                size,
                isDarkMode,
              );
            },
          ),
        ),
      ),
    ],
  );
}
