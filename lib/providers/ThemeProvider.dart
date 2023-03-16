import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class ThemeProvider extends ChangeNotifier{

    late bool isDarkMode;

    ThemeProvider()
    {
      var brightness=SchedulerBinding.instance.window.platformBrightness;
      isDarkMode=brightness==Brightness.dark;
    }

  void changeThemeSettings()
  {
    isDarkMode =!isDarkMode;
  }
    notifyListeners();
  }
