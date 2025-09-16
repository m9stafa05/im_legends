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
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'] as String,
        orElse: () => NotificationType.system,
      ),
    );
  }

  // Factory constructor for Supabase data
  factory NotificationModel.fromSupabase(Map<String, dynamic> row) {
    return NotificationModel(
      id: row['notification_id'] as String,
      title: row['title'] as String,
      message: row['message'] as String,
      time: DateTime.parse(row['created_at'] as String),
      isRead: row['is_read'] as bool,
      type: NotificationType.values.firstWhere(
        (e) => e.name == row['type'] as String,
        orElse: () => NotificationType.system,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'time': time.toIso8601String(),
    'isRead': isRead,
    'type': type.name, // Store as string
  };

  // Method to convert to Supabase format
  Map<String, dynamic> toSupabase() => {
    'notification_id': id,
    'title': title,
    'message': message,
    'created_at': time.toIso8601String(),
    'is_read': isRead,
    'type': type.name, // Store as string
  };

  /// convenience to/from encoded JSON string
  String encode() => json.encode(toJson());
  static NotificationModel decode(String encoded) =>
      NotificationModel.fromJson(json.decode(encoded) as Map<String, dynamic>);

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? time,
    bool? isRead,
    NotificationType? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
}
