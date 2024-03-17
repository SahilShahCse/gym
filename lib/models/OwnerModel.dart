import 'dart:convert';

class Owner {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String gymCode;
  final String? gymName;
  final String? gymLocation;

  Owner({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.gymCode,
    this.gymName,
    this.gymLocation,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      gymCode: json['gymCode'],
      gymName: json['gymName'],
      gymLocation: json['gymLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'gymCode': gymCode,
      'gymName': gymName,
      'gymLocation': gymLocation,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      gymCode: map['gymCode'],
      gymName: map['gymName'],
      gymLocation: map['gymLocation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'gymCode': gymCode,
      'gymName': gymName,
      'gymLocation': gymLocation,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory Owner.fromJsonString(String jsonString) {
    return Owner.fromJson(jsonDecode(jsonString));
  }

  bool verifyPassword(String inputPassword) {
    return inputPassword == password;
  }
}
