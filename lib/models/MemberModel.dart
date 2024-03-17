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
   DateTime? membershipExpiryDate; // Make membershipExpiryDate nullable

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
    this.membershipExpiryDate, // Make membershipExpiryDate nullable
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
          ? DateTime.parse(json['membershipExpiryDate']) // Parse membershipExpiryDate if not null
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
      'membershipExpiryDate': membershipExpiryDate?.toIso8601String(), // Serialize membershipExpiryDate if not null
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
          ? DateTime.parse(map['membershipExpiryDate']) // Parse membershipExpiryDate if not null
          : null,
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
      'membershipExpiryDate': membershipExpiryDate?.toIso8601String(), // Serialize membershipExpiryDate if not null
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
