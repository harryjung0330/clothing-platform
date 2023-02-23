import 'package:clothing_platform/Model/SalesPost.dart';
import 'package:flutter/material.dart';

class SalesPostWrapper with ChangeNotifier{
  SalesPost? salesPost;

  SalesPostWrapper({required this.salesPost});

  void setSalesPost({required SalesPost salesPost})
  {
    this.salesPost = salesPost;
    notifyListeners();
  }

}