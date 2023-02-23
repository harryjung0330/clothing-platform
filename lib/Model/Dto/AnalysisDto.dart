class AnalysisDto {
  AnalysisDto({
    required this.model,
    required this.recommendedPrice,
  });

  final String? model;
  final int? recommendedPrice;

  factory AnalysisDto.fromJson(Map<String, dynamic> json){
    return AnalysisDto(
      model: json["model"],
      recommendedPrice: json["recommended_price"],
    );
  }

  Map<String, dynamic> toJson() => {
    "model": model,
    "recommended_price": recommendedPrice,
  };

  @override
  String toString(){
    return "$model, $recommendedPrice, ";
  }
}
