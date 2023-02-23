import 'package:flutter/material.dart';

import '../SalesPost.dart';

class SalesPostListWrapper with ChangeNotifier
{

  late Future<List<SalesPost>> salesPosts;

  SalesPostListWrapper({required this.salesPosts});

  void setSalesPosts({required Future<List<SalesPost>> salesPosts})
  {
    this.salesPosts = salesPosts;
    notifyListeners();
  }


}