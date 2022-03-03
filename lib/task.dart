import 'dart:convert';

class Taskmodel {
  String title;
  int datetime;
  String time;
  String description;
  int value;
  Taskmodel({
    required this.title,
    required this.datetime,
    required this.time,
    required this.description,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'datetime': datetime,
      'time': time,
      'description': description,
      'value': value,
    };
  }

  factory Taskmodel.fromMap(Map<String, dynamic> map) {
    return Taskmodel(
      title: map['title'] ?? '',
      datetime: map['datetime']?.toInt() ?? 0,
      time: map['time'] ?? '',
      description: map['description'] ?? '',
      value: map['value']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Taskmodel.fromJson(String source) =>
      Taskmodel.fromMap(json.decode(source));
}
