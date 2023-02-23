class SalesPostGetResponseDto {

  SalesPostGetResponseDto({
    required this.salesPostId,
    required this.ownerId,
    required this.salesPostPictureServiceGetDtos,
    required this.price,
    required this.recommendedPrice,
    required this.brand,
    required this.model,
    required this.content,
  });

  int salesPostId;
  int ownerId;
  List<SalesPostPictureServiceGetDto> salesPostPictureServiceGetDtos;
  int price;
  int recommendedPrice;
  String brand;
  String model;
  String content;

  factory SalesPostGetResponseDto.fromJson(Map<String, dynamic> json) => SalesPostGetResponseDto(
    salesPostId: json["salesPostId"],
    ownerId: json["ownerId"],
    salesPostPictureServiceGetDtos: List<SalesPostPictureServiceGetDto>.from(json["salesPostPictureServiceGetDtos"].map((x) => SalesPostPictureServiceGetDto.fromJson(x))),
    price: json["price"],
    recommendedPrice: json["recommendedPrice"],
    brand: json["brand"],
    model: json["model"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "salesPostId": salesPostId,
    "ownerId": ownerId,
    "salesPostPictureServiceGetDtos": List<dynamic>.from(salesPostPictureServiceGetDtos.map((x) => x.toJson())),
    "price": price,
    "recommendedPrice": recommendedPrice,
    "brand": brand,
    "model": model,
    "content": content,
  };
}

class SalesPostPictureServiceGetDto {
  SalesPostPictureServiceGetDto({
    required this.pictUrl,
    required this.position,
  });

  String pictUrl;
  String position;

  factory SalesPostPictureServiceGetDto.fromJson(Map<String, dynamic> json) => SalesPostPictureServiceGetDto(
    pictUrl: json["pictUrl"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "pictUrl": pictUrl,
    "position": position,
  };
}