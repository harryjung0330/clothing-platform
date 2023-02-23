class LogInResponseDto {
  LogInResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
  });

  String accessToken;
  String refreshToken;
  int userId;

  factory LogInResponseDto.fromJson(Map<String, dynamic> json) => LogInResponseDto(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "user_id": userId,
  };
}