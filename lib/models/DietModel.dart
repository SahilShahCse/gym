import 'dart:convert';

class DietPlan {
  final String id;
  final String memberId;
  final List<List<String>> dailyMeals; // List of meals for each day
  final DateTime creationDate;
  DateTime lastUpdatedDate;

  DietPlan({
    required this.id,
    required this.memberId,
    required this.dailyMeals,
    required this.creationDate,
    required this.lastUpdatedDate,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      id: json['id'],
      memberId: json['memberId'],
      dailyMeals: List<List<String>>.from(json['dailyMeals']
          .map((dayMeals) => List<String>.from(dayMeals))),
      creationDate: DateTime.parse(json['creationDate']),
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'dailyMeals': dailyMeals
          .map((dayMeals) => List<String>.from(dayMeals))
          .toList(),
      'creationDate': creationDate.toIso8601String(),
      'lastUpdatedDate': lastUpdatedDate.toIso8601String(),
    };
  }

  factory DietPlan.fromMap(Map<String, dynamic> map) {
    return DietPlan(
      id: map['id'],
      memberId: map['memberId'],
      dailyMeals: List<List<String>>.from(
          map['dailyMeals'].map((dayMeals) => List<String>.from(dayMeals))),
      creationDate: DateTime.parse(map['creationDate']),
      lastUpdatedDate: DateTime.parse(map['lastUpdatedDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'dailyMeals': dailyMeals
          .map((dayMeals) => List<String>.from(dayMeals))
          .toList(),
      'creationDate': creationDate.toIso8601String(),
      'lastUpdatedDate': lastUpdatedDate.toIso8601String(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory DietPlan.fromJsonString(String jsonString) {
    return DietPlan.fromJson(jsonDecode(jsonString));
  }
}
