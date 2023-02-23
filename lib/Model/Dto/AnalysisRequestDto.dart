class AnalysisRequestDto {
  AnalysisRequestDto({
    required this.front,
    required this.back,
    required this.left,
    required this.right,
  });

  final String? front;
  final String? back;
  final String? left;
  final String? right;

  factory AnalysisRequestDto.fromJson(Map<String, dynamic> json){
    return AnalysisRequestDto(
      front: json["front"],
      back: json["back"],
      left: json["left"],
      right: json["right"],
    );
  }

  Map<String, dynamic> toJson() => {
    "front": front,
    "back": back,
    "left": left,
    "right": right,
  };

  @override
  String toString(){
    return "$front, $back, $left, $right, ";
  }
}
