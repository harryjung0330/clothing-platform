class MessageFormat {
  MessageFormat({
    required this.message,
    required this.data,
    required this.timestamp,
  });

  String message;
  Object data;
  DateTime timestamp;

  factory MessageFormat.fromJson(Map<String, dynamic> json) => MessageFormat(
    message: json["message"],
    data: json["data"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
    "timestamp": timestamp.toIso8601String(),
  };
}

