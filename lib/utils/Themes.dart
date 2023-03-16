import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';




final ThemeData LIGHT_THEME_DATA = ThemeData(

  
  useMaterial3: true,
  snackBarTheme: SnackBarThemeData(backgroundColor: Colors.green,contentTextStyle: TextStyle(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey.shade400
  ),

  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    elevation: 5.0,

  ),

  iconTheme: IconThemeData(color: Colors.blueAccent),
  appBarTheme:  AppBarTheme(
    
    backgroundColor: Colors.white,

    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 18.sp,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    ),
    

      textTheme: TextTheme(
          displayMedium: TextStyle(color:Colors.black),
          bodyMedium: TextStyle(color:Colors.black),
          headlineLarge: TextStyle(color: Colors.black),
          headlineMedium:TextStyle(color:Colors.white),
          bodySmall: TextStyle(color: Colors.white,fontSize: 14.sp),
          headlineSmall: TextStyle(color:Colors.black),

    displaySmall: TextStyle(color:Colors.white,fontSize: 8.sp,fontWeight: FontWeight.w200),//post content, etc for color
    titleLarge: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w800),//Post title
    titleMedium: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.w100)// User name and date
    
      ),



  ),
  scaffoldBackgroundColor: Colors.white,
  // primaryColor: Colors.amber, //app bar and button color
  brightness: Brightness.light,

  cardTheme: CardTheme(color: Colors.white)
);
final DARK_THEME_DATA = ThemeData(
  
  useMaterial3: true,
  
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black.withOpacity(0),
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.black
  ),

  iconTheme: IconThemeData(color: Colors.blueAccent),
  bottomAppBarTheme: const BottomAppBarTheme(
    color:Color(0xFF270E4D),

    elevation: 15.0,

  ),
  
  appBarTheme:  AppBarTheme(
    
    titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:18.sp),
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,

    elevation: 0,
    

    iconTheme: IconThemeData(
      color: Colors.white,
      size: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
    ),
  ),
  scaffoldBackgroundColor: Colors.black,//Color(0xFF1D160F),
  // primaryColor: Colors.amber, //app bar and button color
  brightness: Brightness.dark,
    textButtonTheme: TextButtonThemeData(style: ElevatedButton.styleFrom(foregroundColor: Colors.blue)),
  textTheme: TextTheme(
    displayMedium: TextStyle(color:Colors.white),
    
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium:TextStyle(color:Colors.black,),
    bodySmall: TextStyle(color: Colors.black,fontSize: 12.sp),
    headlineSmall: TextStyle(color:Colors.white),
    bodyMedium: TextStyle(color:Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w200),
    bodyLarge: TextStyle(color:Colors.white,fontSize: 10.sp,fontWeight: FontWeight.w200),//post content, etc for color
    titleLarge: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w800),//Post title
    titleMedium: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold)// User name and date
    


  ),
  snackBarTheme: SnackBarThemeData(backgroundColor: Colors.green,contentTextStyle: TextStyle(color: Colors.white)),

  cardTheme: CardTheme(color: Colors.white12)
);
/*TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.black : Colors.red,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.red,
    ),
  );
}

TextStyle get titleTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.red,
    ),
  );
}

TextStyle get subtitleTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
    ),
  );
}*/

TextStyle get subjectTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
  );
}

InputDecoration formInputDecoration = InputDecoration(
  hintStyle: const TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.black45,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.black54,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.black,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
);

