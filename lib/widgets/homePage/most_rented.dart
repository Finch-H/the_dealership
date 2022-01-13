
import 'package:flutter/material.dart';
import 'package:the_dealership/data/cars.dart';

import 'car.dart';
import 'category.dart';

Widget buildMostRented(Size size, bool isDarkMode) {
  return Column(
    children: [
      buildCategory('Most Rented', size, isDarkMode),
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
