import 'dart:convert';

class WorkoutPlan {
  final String id;
  final String memberId;
  final List<List<String>> dailyExercises; // List of exercises for 7 days
  final DateTime creationDate;
  DateTime lastUpdatedDate;

  WorkoutPlan({
    required this.id,
    required this.memberId,
    required this.dailyExercises,
    required this.creationDate,
    required this.lastUpdatedDate,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      id: json['id'],
      memberId: json['memberId'],
      dailyExercises: List<List<String>>.from(json['dailyExercises']
          .map((dayExercises) => List<String>.from(dayExercises))),
      creationDate: DateTime.parse(json['creationDate']),
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'dailyExercises': dailyExercises
          .map((dayExercises) => List<String>.from(dayExercises))
          .toList(),
      'creationDate': creationDate.toIso8601String(),
      'lastUpdatedDate': lastUpdatedDate.toIso8601String(),
    };
  }

  factory WorkoutPlan.fromMap(Map<String, dynamic> map) {
    return WorkoutPlan(
      id: map['id'],
      memberId: map['memberId'],
      dailyExercises: List<List<String>>.from(
          map['dailyExercises'].map((dayExercises) => List<String>.from(dayExercises))),
      creationDate: DateTime.parse(map['creationDate']),
      lastUpdatedDate: DateTime.parse(map['lastUpdatedDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'dailyExercises': dailyExercises
          .map((dayExercises) => List<String>.from(dayExercises))
          .toList(),
      'creationDate': creationDate.toIso8601String(),
      'lastUpdatedDate': lastUpdatedDate.toIso8601String(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory WorkoutPlan.fromJsonString(String jsonString) {
    return WorkoutPlan.fromJson(jsonDecode(jsonString));
  }
}
