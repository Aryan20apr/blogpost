import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';



/*
* Read this please...
* First of all import the neumorphic package that you might have installed earlier
* Next import this dart file
* Next create an instance of the NeumorphicStuffs() class like final className = NeumorphicStuffs()
* Next implement the different class functions inside your column/row/container to get your custom widget
* */

/*NOTE:
*If you want to design your custom neumorphic <thing> then make sure this is the style:
* all the depth, color, shadowLightColor and shadowDArkCOlor must be the same as this for the universal stuff you would be implementing
* YOu can mess around with the borderRadius.circular() increase or decrease it according to needs
* style: NeumorphicStyle(
          depth: 5,
          lightSource: LightSource.topLeft,
          color: Color(0xFF242323),
          shadowDarkColor: Color(0xFF1d1d1d),
          shadowLightColor: Color(0xFF535151),
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          // border: NeumorphicBorder()
        ),
* */

class NeumorphicStuffs {
  //THis is the function that will return you the universal elevated button, add your custom padding with it
  Widget getUniversalButton(
      {required String text, required Function ontapped}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: NeumorphicButton(
        margin: EdgeInsets.only(top: 0.0),
        onPressed: () {
          ontapped();
        },
        style: NeumorphicStyle(
          depth: 5,
          lightSource: LightSource.topLeft,
          color: Color(0xFF242323),
          shadowDarkColor: Color(0xFF1d1d1d),
          shadowLightColor: Color(0xFF535151),
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          // border: NeumorphicBorder()
        ),
        padding: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:textColor,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //This is the submit/go-to-some/important features button link button
  Widget getImportantButton(
      {required String text, required Function ontapped,}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: NeumorphicButton(
        margin: EdgeInsets.only(top: 0.0),
        onPressed: () {
          ontapped();
        },
        style: NeumorphicStyle(
          depth: 5,
          lightSource: LightSource.topLeft,
          color: Color(0xFF279c43),
          shadowDarkColor: Color(0xFF272626),
          shadowLightColor: Color(0xFF6f6c6c),
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          // border: NeumorphicBorder()
        ),
        padding: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget getImportantRedButton(
      {required String text, required Function ontapped}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: NeumorphicButton(
        margin: EdgeInsets.only(top: 0.0),
        onPressed: () {
          ontapped();
        },
        style: NeumorphicStyle(
          depth: 5,
          lightSource: LightSource.topLeft,
          color: Colors.red,
          shadowDarkColor: Color(0xFF272626),
          shadowLightColor: Color(0xFF6f6c6c),
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          // border: NeumorphicBorder()
        ),
        padding: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  //THis is floating action button with an icon inside it
  Widget getFloatingButtonWithIcon({required IconData iconInfo}) {
    return NeumorphicFloatingActionButton(
      style: NeumorphicStyle(
        depth: 8,
        lightSource: LightSource.topLeft,
        color: Color(0xFF242323),
        shadowDarkColor: Color(0xFF272626),
        shadowLightColor: Color(0xFF6f6c6c),
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      // border: NeumorphicBorder()
      child: Icon(
        Icons.add,
        size: 30,
        color: textColor,
      ),
      onPressed: () {
        print('icon pressed');
      },
    );
  }

  //NOTE: THIS IS THE DIFFICULT ONE SINCE WE HAVE TO CHANGE COLORS SO THAT FUNCTION YOU WILL IMPLEMENT IN A STATEFUL FUNCTION
  Widget getCardForHomeScreen(
      {required String text, required Function ontapped, bool? changeColor}) {
    return Padding(
      //Use Expanded widget to divide the screen width into two equal parts
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: NeumorphicButton(
        margin: EdgeInsets.only(top: 12),
        onPressed: () {
          ontapped(); //Here set the boolean variable like changeColor = !changeColor inside a setState and pass the function here in the parameter list above
        },
        style: NeumorphicStyle(
          depth: 8,
          lightSource: LightSource.topLeft,
          color: Color(0xFF279c43),
          //You can comment this line and uncomment the other line
          // color: !changeColor? Color(0xFF272626): Color(0xFF279c43),
          shadowDarkColor: Color(0xFF272626),
          shadowLightColor: Color(0xFF6f6c6c),
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          // border: NeumorphicBorder()
        ),
        padding: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //THis is the parameter that will be changed by the user
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  getTextFieldStyle() {
    //TextInputTYpe for keyboardtype
    return NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: -2,
      lightSource: LightSource.topLeft,
      color: Colors.white,
      shadowDarkColor: Color(0xFF272626),
      shadowLightColor: Color(0xFF6f6c6c),
    );
  }

  getStyleForBackButton() {
    return NeumorphicStyle(
      depth: 8,
      lightSource: LightSource.topLeft,
      color: Color(0xFF242323),
      shadowDarkColor: Color(0xFF272626),
      shadowLightColor: Color(0xFF6f6c6c),
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.circle(),
    );
  }

  getStyleForDropDown() {
    return NeumorphicStyle(
      depth: 8,
      lightSource: LightSource.topLeft,
      color: Color(0xFF242323),
      shadowDarkColor: Color(0xFF272626),
      shadowLightColor: Color(0xFF6f6c6c),
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(12),
      ),
    );
  }
}
