import 'Enum/Position.dart';

class SalesPostPicture{
  late Position position;
  late String pictUrl;

  SalesPostPicture({required this.position, required this.pictUrl});

  factory SalesPostPicture.fromJson(Map<String, dynamic> json) => SalesPostPicture(
    pictUrl: json["pictUrl"],
    position: Position.values.byName(json["position"].toString())
  );

  Map<String, dynamic> toJson() => {
    "pictUrl": pictUrl,
    "position": position.name.toString(),
  };

}