import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// https://www.boltuix.com/2023/02/how-do-you-use-typography-styles-in.html

const primaryColor = Color(0xFF0C9869);
const textColor = Color(0xFF3C4046);
const backgroundColor = Color(0xFFF9F8FD);

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // colorSchemeSeed: Colors.green,
    primaryColor: Colors.green,
    // scaffoldBackgroundColor: const Color(0xFFF9F8FD),
    // textTheme: TextTheme(
    //   bodyLarge: GoogleFonts.montserrat(color: Colors.green),
    // ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // textTheme: TextTheme(
    //   bodyLarge: GoogleFonts.montserrat(color: Colors.green),
    // ),
  );
}


// const colorList = <Color>[
//   Colors.blue,
//   Colors.teal,
//   Colors.green,
//   Colors.red,
//   Colors.purple,
//   Colors.deepPurple,
//   Colors.orange,
//   Colors.pink,
//   Colors.pinkAccent,
// ];



// class AppTheme {

//   final int selectedColor;

//   AppTheme({
//     this.selectedColor = 0
//   }): assert( selectedColor >= 0, 'Selected color must be greater then 0' ),  
//       assert( selectedColor < colorList.length, 
//         'Selected color must be less or equal than ${ colorList.length - 1 }');

//   ThemeData getTheme() => ThemeData(
//     useMaterial3: true,
//     colorSchemeSeed: colorList[ selectedColor ],
//     appBarTheme: const AppBarTheme(
//       centerTitle: false
//     ),
//   );

// }

// class _CustomGradient extends StatelessWidget {
//   final AlignmentGeometry begin;
//   final AlignmentGeometry end;
//   final List<double> stops;
//   final List<Color> colors;

//   const _CustomGradient({
//     this.begin = Alignment.centerLeft,
//     this.end = Alignment.centerRight,
//     required this.stops,
//     required this.colors,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: begin,
//             end: end,
//             stops: stops,
//             colors: colors,
//           ),
//         ),
//       ),
//     );
//   }
// }