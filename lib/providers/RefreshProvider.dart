import 'package:flutter/material.dart';

class RefreshProvider extends ChangeNotifier
{
  bool shouldRefresh=false;

void changeRefresh()
{
  shouldRefresh=true;
  notifyListeners();
}
}