class LogInRequestDto {
  LogInRequestDto({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LogInRequestDto.fromJson(Map<String, dynamic> json) => LogInRequestDto(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };

}