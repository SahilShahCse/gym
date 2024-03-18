import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Member {
  String id;
  String fullName;
  String email;
  String password;
  String gymCode;
  String? phoneNumber;
  String? address;
  bool isActive;
  bool isPaid;
  DateTime? membershipExpiryDate;
  String? trainerId;
  List<Information>? workout; // New field for workout information
  List<Information>? diet; // New field for diet information

  Member({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.gymCode,
    this.phoneNumber,
    this.address,
    this.isActive = true,
    this.isPaid = false,
    this.membershipExpiryDate,
    this.trainerId,
    this.workout,
    this.diet,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      gymCode: json['gymCode'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      isActive: json['isActive'],
      isPaid: json['isPaid'],
      membershipExpiryDate: json['membershipExpiryDate'] != null
          ? DateTime.parse(json['membershipExpiryDate'])
          : null,
      trainerId: json['trainerId'],
      workout: json['workout'] != null
          ? List<Information>.from(json['workout'].map((x) => Information.fromJson(x)))
          : null,
      diet: json['diet'] != null
          ? List<Information>.from(json['diet'].map((x) => Information.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'gymCode': gymCode,
      'phoneNumber': phoneNumber,
      'address': address,
      'isActive': isActive,
      'isPaid': isPaid,
      'membershipExpiryDate': membershipExpiryDate?.toIso8601String(),
      'trainerId': trainerId,
      'workout': workout?.map((info) => info.toJson()).toList(),
      'diet': diet?.map((info) => info.toJson()).toList(),
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      gymCode: map['gymCode'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      isActive: map['isActive'],
      isPaid: map['isPaid'],
      membershipExpiryDate: map['membershipExpiryDate'] != null
          ? (map['membershipExpiryDate'] as Timestamp).toDate()
          : null,
      trainerId: map['trainerId'],
      workout: map['workout'] != null
          ? List<Information>.from(map['workout'].map((x) => Information.fromMap(x)))
          : null,
      diet: map['diet'] != null ? List<Information>.from(map['diet'].map((x) => Information.fromMap(x))) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'gymCode': gymCode,
      'phoneNumber': phoneNumber,
      'address': address,
      'isActive': isActive,
      'isPaid': isPaid,
      'membershipExpiryDate': membershipExpiryDate != null
          ? Timestamp.fromDate(membershipExpiryDate!)
          : null,
      'trainerId': trainerId,
      'workout': workout?.map((info) => info.toMap()).toList(),
      'diet': diet?.map((info) => info.toMap()).toList(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory Member.fromJsonString(String jsonString) {
    return Member.fromJson(jsonDecode(jsonString));
  }

  bool verifyPassword(String inputPassword) {
    return inputPassword == password;
  }
}

class Information {
  String heading;
  String description;

  Information({
    required this.heading,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'description': description,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'heading': heading,
      'description': description,
    };
  }

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      heading: json['heading'],
      description: json['description'],
    );
  }

  factory Information.fromMap(Map<String, dynamic> map) {
    return Information(
      heading: map['heading'],
      description: map['description'],
    );
  }
}

