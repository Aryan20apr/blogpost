import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF383737);
const buttonColor = Color(0xFF279c43);
const textColor = Colors.white;
const darkTextColor = Color(0xFF0e6626);
Color textFieldColor=Colors.black;
const infotextColorDark=Colors.white;
const infotextColorLight=Colors.black;

Color floatingbuttonbackground=Colors.green.shade800;
Color floatingbuttonforeground=Colors.white;

const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFC1C1C1);
const kBlackColor = Color(0xFF101010);
const kSelectedAnswer=Color(0xFF6AE792);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

 List<List<Color>> colorListStudent=[[
    Colors.blue.shade200,
    Colors.blue.shade700
  ],[Colors.red.shade200,Colors.red.shade700],[Colors.green.shade200,Colors.green.shade700],[Colors.purple.shade200,Colors.purple.shade700]];
  List<List<Color>> colorListDarkMode=[[
    Colors.blue.shade200,
    Colors.blue.shade700
  ],[Colors.red.shade200,Colors.red.shade700],[Colors.green.shade200,Colors.green.shade700],[Colors.purple.shade200,Colors.purple.shade700]];  
const double kDefaultPadding = 20.0;


//Validator Logic
// if (_formKey.currentState!.validate()) {
// // If the form is valid, display a snackbar. In the real world,
// // you'd often call a server or save the information in a database.
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(content: Text('Processing Data')),
// );
// }