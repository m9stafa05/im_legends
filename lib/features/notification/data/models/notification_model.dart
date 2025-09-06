import 'dart:convert';

enum NotificationType { welcome, update, security, promotion, system }

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  bool isRead;
  final NotificationType type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      time: DateTime.parse(json['time'] as String),
      isRead: json['isRead'] as bool,
      type: NotificationType.values[json['type'] as int],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'time': time.toIso8601String(),
    'isRead': isRead,
    'type': type.index,
  };

  /// convenience to/from encoded JSON string
  String encode() => json.encode(toJson());
  static NotificationModel decode(String encoded) =>
      NotificationModel.fromJson(json.decode(encoded) as Map<String, dynamic>);
}
