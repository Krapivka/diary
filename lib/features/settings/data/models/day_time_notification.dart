import 'dart:convert';

class TimeNotification {
  TimeNotification({
    required this.hour,
    required this.minute,
  });

  int hour;
  int minute;

  TimeNotification copyWith({
    int? hour,
    int? minute,
  }) {
    return TimeNotification(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  factory TimeNotification.fromMap(Map<String, dynamic> map) {
    return TimeNotification(
      hour: map['hour']?.toInt() ?? 0,
      minute: map['minute']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeNotification.fromJson(String source) =>
      TimeNotification.fromMap(json.decode(source));

  @override
  String toString() => 'DayTimeNotification(hour: $hour, minute: $minute)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeNotification &&
        other.hour == hour &&
        other.minute == minute;
  }

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;
}
