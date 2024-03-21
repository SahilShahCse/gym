import 'dart:convert';

class Owner {
  String id;
  String name;
  String? email;
  String? password;
  String? gymCode;
  String? gymName;
  String? gymLocation;
  String? phoneNumber;
  int age;
  String gender;
  String? role;

  Owner({
    required this.id,
    required this.name,
    this.email,
    this.password,
    this.gymCode,
    this.gymName,
    this.gymLocation,
    required this.age,
    required this.gender,
    this.role,
    this.phoneNumber
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      gymCode: json['gymCode'],
      gymName: json['gymName'],
      gymLocation: json['gymLocation'],
      phoneNumber: json['phoneNumber'],
      age: json['age'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'gymCode': gymCode,
      'gymName': gymName,
      'gymLocation': gymLocation,
      'age': age,
      'gender': gender,
      'phoneNumber' : phoneNumber,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      gymCode: map['gymCode'],
      gymName: map['gymName'],
      gymLocation: map['gymLocation'],
      age: map['age'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'gymCode': gymCode,
      'gymName': gymName,
      'gymLocation': gymLocation,
      'age': age,
      'gender': gender,
      'role' : role,
      'phoneNumber' : phoneNumber,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory Owner.fromJsonString(String jsonString) {
    return Owner.fromJson(jsonDecode(jsonString));
  }
}
