import 'package:flutter/material.dart';

class SalesPostViewState with ChangeNotifier
{
  static final int SALES_POST_LIST = 0;
  static final int SALES_POST_DETAIL = 1;

  late int currentState;

  SalesPostViewState({required this.currentState});

  void changeState({required int currentState})
  {
    this.currentState = currentState;
    notifyListeners();
  }

}
