import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Member {
  String id;
  String name;
  String? email;
  String? password;
  String? gymCode;
  String? phoneNumber;
  String? address;
  bool? isActive;
  DateTime? membershipExpiryDate;
  String? trainerId;
  List<Information>? workout;
  List<Information>? diet;
  double? weight;
  double? height;
  int? age;
  String? gender;
  String? role;
  List<PaymentRecord>? paymentRecords; // New field to track payment records

  Member({
    required this.id,
    required this.name,
    this.password,
    this.gymCode,
    this.email,
    this.phoneNumber,
    this.address,
    this.isActive = true,
    this.membershipExpiryDate,
    this.trainerId,
    this.workout,
    this.diet,
    this.weight,
    this.height,
    this.age,
    this.gender,
    this.role,
    this.paymentRecords, // Initialize payment records
  });

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      gymCode: map['gymCode'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      isActive: map['isActive'],
      membershipExpiryDate: map['membershipExpiryDate'] != null
          ? (map['membershipExpiryDate'] as Timestamp).toDate()
          : null,
      trainerId: map['trainerId'],
      workout: map['workout'] != null
          ? List<Information>.from(
          map['workout'].map((x) => Information.fromMap(x)))
          : null,
      diet: map['diet'] != null
          ? List<Information>.from(
          map['diet'].map((x) => Information.fromMap(x)))
          : null,
      weight: map['weight'],
      height: map['height'],
      age: map['age'],
      gender: map['gender'],
      role: map['role'],
      paymentRecords: map['paymentRecords'] != null
          ? List<PaymentRecord>.from(
          map['paymentRecords'].map((x) => PaymentRecord.fromMap(x)))
          : null, // Initialize payment records from map
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'gymCode': gymCode,
      'phoneNumber': phoneNumber,
      'address': address,
      'isActive': isActive,
      'membershipExpiryDate': membershipExpiryDate != null
          ? Timestamp.fromDate(membershipExpiryDate!)
          : null,
      'trainerId': trainerId,
      'workout': workout?.map((info) => info.toMap()).toList(),
      'diet': diet?.map((info) => info.toMap()).toList(),
      'weight': weight,
      'height': height,
      'age': age,
      'gender': gender,
      'role': role,
      'paymentRecords': paymentRecords
          ?.map((record) => record.toMap())
          .toList(), // Include payment records in map
    };
  }
}

class Information {
  String heading;
  String description;

  Information({
    required this.heading,
    required this.description,
  });

  factory Information.fromMap(Map<String, dynamic> map) {
    return Information(
      heading: map['heading'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'heading': heading,
      'description': description,
    };
  }
}

class PaymentRecord {
  DateTime expireDate;
  DateTime startingDate;
  double amount;

  PaymentRecord({
    required this.expireDate,
    required this.amount,
    required this.startingDate,
  });

  factory PaymentRecord.fromMap(Map<String, dynamic> map) {
    return PaymentRecord(
      expireDate: (map['date'] as Timestamp).toDate(),
      amount: map['amount'],
      startingDate: map['startingDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(expireDate),
      'amount': amount,
      'startingDate' : startingDate,
    };
  }
}
