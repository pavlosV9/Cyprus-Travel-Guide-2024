import 'package:flutter/material.dart';

TextStyle kSecondOverImage =  TextStyle(

  color: Colors.white.withOpacity(0.85), // Slightly transparent white
  fontSize: 20, // Smaller font size than the welcome message
  fontFamily: 'Roboto',
  fontWeight: FontWeight.normal,


  // You may remove shadows if the text should be less prominent
);
TextStyle kMainOverImage = const TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.bold,
  shadows: [
    Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);
TextStyle overTransition = const TextStyle(
  color: Colors.white,
  fontSize: 25, // Adjust the size as needed
  fontWeight: FontWeight.w700, // Bold
  shadows: [ // Optional: text shadow
     Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);
TextStyle klocation2 = const TextStyle(
  color: Colors.white,
  fontSize: 35, // Adjust the size as needed
  fontWeight: FontWeight.w700, // Bold
  shadows: [ // Optional: text shadow
    Shadow(
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);
TextStyle knameStyle = const TextStyle(
  color: Colors.white,
  fontSize: 35, // Adjust the size as needed
  fontWeight: FontWeight.w700, // Bold
  shadows: [ // Optional: text shadow
    Shadow(
      offset: Offset(5.0, 5.0),
      blurRadius: 28.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);
TextStyle kTextButton =const  TextStyle(
  color: Colors.white,
  fontSize: 20, // Adjust the size as needed
  fontWeight: FontWeight.w500, // Bold
  shadows: [ // Optional: text shadow
     Shadow(
      offset:  Offset(2.0, 2.0),
      blurRadius: 2.0,
      color:  Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);
TextStyle ktitleName = const TextStyle(
  color: Colors.white,
  fontSize: 30, // Adjust the size as needed
  fontWeight: FontWeight.w700, // Bold
  shadows: [ // Optional: text shadow
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 2.0,
      color:  Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);
  TextStyle kOverTabBar = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.white, // Text color for contrast
    shadows:  [
    Shadow(
    offset: Offset(0, 1),
    blurRadius: 2.5,
    color: Color.fromARGB(255, 0, 0, 0),
    ),
    ],
    );
  const kFavourites =TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
  color: Colors.black,
   );
  TextStyle kCityText = const TextStyle(
  color: Colors.black,
  fontSize: 30,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w800);

const kDescription= TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.w600,
);
const overImage =TextStyle(
color: Colors.white, // White text for better readability
fontSize: 24, // Choose an appropriate font size
fontWeight: FontWeight.bold, // Bold text for better readability
shadows: <Shadow>[
Shadow(
offset: Offset(1.0, 1.0),
blurRadius: 3.0,
color: Colors.black, // Text shadow for better legibility
),
],
);
 TextStyle OverTabBar = const TextStyle(
   fontWeight: FontWeight.w800,
   color: Colors.white, // Text color for contrast
   shadows: [
     Shadow(
       offset: Offset(0, 1),
       blurRadius: 2.5,
       color: Color.fromARGB(255, 0, 0, 0),
     ),
   ],
 );
TextStyle kOverTabBar2=const TextStyle(
fontWeight: FontWeight.w800,
color: Colors.white, // White text for contrast
shadows: [
Shadow( // Text shadow
offset: Offset(0, 0),
blurRadius: 7.5,  color: Color.fromARGB(255, 0, 0, 0),
),
],
);