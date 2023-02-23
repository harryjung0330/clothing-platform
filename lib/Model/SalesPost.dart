
import 'package:clothing_platform/Model/SalesPostPicture.dart';

import 'Enum/Brand.dart';

class SalesPost{

  late int salesPostId;
  late List<SalesPostPicture> pictUrl;
  late Brand brand;
  late String model;
  late String content;
  late double price;
  late double recommendedPrice;
  late int ownerId;

  SalesPost({required this.salesPostId, required this.pictUrl, required this.ownerId,
    required this.brand, required this.model, required this.content, required this.price, required this.recommendedPrice});

  factory SalesPost.fromJson(Map<String, dynamic> json) {
    List<SalesPostPicture> temp = [];

    for(Map<String,dynamic> s in json["salesPostPictureServiceGetDtos"] )
      {
        temp.add(SalesPostPicture.fromJson(s));
      }

    return SalesPost(
      salesPostId: json["salesPostId"],
      ownerId: int.parse(json["ownerId"].toString()) ?? -1,
      pictUrl: temp,
      price: json["price"],
      recommendedPrice: json["recommendedPrice"],
      brand: Brand.values.byName(json["brand"]),
      model: json["model"],
      content: json["content"],
    );
  }
  Map<String, dynamic> toJson() => {
    "salesPostId": salesPostId,
    "ownerId": ownerId,
    "salesPostPictureServiceGetDtos": pictUrl.map((e) => e.toJson()),
    "price": price,
    "recommendedPrice": recommendedPrice,
    "brand": brand,
    "model": model,
    "content": content,
  };
}
