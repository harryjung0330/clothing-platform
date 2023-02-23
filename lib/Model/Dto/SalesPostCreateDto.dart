import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import '../Enum/Brand.dart';
import '../SalesPostPicture.dart';

class SalesPostCreateDto extends PropertyChangeNotifier<String>
{

  static final BRAND= "brand";
  static final MODEL = "model";
  static final String CONTENT = "content";
  static final PRICE = "price";
  static final RECOMMENDED_PRICE =  "recommendedPrice";
  static final FRONT = "front";
  static final BACK = "back";
  static final LEFT = "left";
  static final RIGHT = "right";

  Brand? brand;
  String? model;
  String? content;
  double? price;
  double? recommendedPrice;
  String? front;
  String? back;
  String? left;
  String? right;

  SalesPostCreateDto();

  void resetAll(){
    this.brand = null;
    this.model = null;
    this.content = null;
    this.price = null;
    this.recommendedPrice = null;
    this.front = null;
    this.back = null;
    this.left = null;
    this.right = null;

    notifyListeners();
  }

  void setBrand(Brand brand){
    this.brand = brand;
    notifyListeners(BRAND);
  }

  void setModel(String model)
  {
    this.model = model;
    notifyListeners(MODEL);
  }

  void setContent(String content){
    this.content = content;
    notifyListeners(CONTENT);
  }

  void setPrice(double price)
  {
    this.price = price;
    notifyListeners(PRICE);
  }

  void setRecommendedPrice(double price)
  {
    this.recommendedPrice = price;
    notifyListeners(RECOMMENDED_PRICE);
  }

  void setFront(String front)
  {
    this.front = front;
    notifyListeners(FRONT);
  }

  void setBack(String back){
    this.back = back;
    notifyListeners(BACK);
  }

  void setLeft(String left){
    this.left = left;
    notifyListeners(LEFT);
  }

  void setRight(String right){
    this.right = right;
    notifyListeners(RIGHT);
  }
}