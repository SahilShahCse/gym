import 'dart:convert';

class Trainer {
  String? id;
  String? name;
  String? phoneNumber;
  String? emailId;
  String? address;
  int? salary;
  String? shift;
  List<String>? personalTrainingId;
  String? gymCode;
  bool? isInGym; // New field for gym attendance status
  List<AttendanceLog>? attendanceLogs; // New field for attendance logs
  int? age; // New field for age
  String? gender; // New field for gender
  bool? canSeeMobileNumbers; // New field for permission to see mobile numbers
  bool? canUpdatePaymentStatus; // New field for permission to update payment status
  bool? isTrainer;

  Trainer({
    this.id,
    this.name,
    this.phoneNumber,
    this.emailId,
    this.address,
    this.salary,
    this.shift,
    this.personalTrainingId,
    this.gymCode,
    this.isInGym,
    this.attendanceLogs,
    this.age,
    this.gender,
    this.canSeeMobileNumbers,
    this.canUpdatePaymentStatus,
    this.isTrainer
  });

  // Method to convert Trainer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'emailId': emailId,
      'address': address,
      'salary': salary,
      'shift': shift,
      'personalTrainingId': personalTrainingId,
      'gymCode': gymCode,
      'isInGym': isInGym,
      'attendanceLogs': attendanceLogs?.map((log) => log.toMap()).toList(),
      'age': age,
      'gender': gender,
      'canSeeMobileNumbers': canSeeMobileNumbers,
      'canUpdatePaymentStatus': canUpdatePaymentStatus,
      'isTrainer' : isTrainer,
    };
  }

  // Method to convert Map to Trainer object
  factory Trainer.fromMap(Map<String, dynamic> map) {
    return Trainer(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      emailId: map['emailId'],
      address: map['address'],
      salary: map['salary'],
      shift: map['shift'],
      personalTrainingId: List<String>.from(map['personalTrainingId'] ?? []),
      gymCode: map['gymCode'],
      isInGym: map['isInGym'],
      attendanceLogs: map['attendanceLogs'] != null
          ? List<AttendanceLog>.from(map['attendanceLogs'].map((x) => AttendanceLog.fromMap(x)))
          : null,
      age: map['age'],
      gender: map['gender'],
      canSeeMobileNumbers: map['canSeeMobileNumbers'],
      canUpdatePaymentStatus: map['canUpdatePaymentStatus'],
      isTrainer: map['isTrainer'],
    );
  }

  // Method to convert Trainer object to JSON string
  String toJson() => json.encode(toMap());

  // Method to convert JSON string to Trainer object
  factory Trainer.fromJson(String source) => Trainer.fromMap(json.decode(source));
}

class AttendanceLog {
  DateTime? signInTime;
  DateTime? signOutTime;

  AttendanceLog({
    this.signInTime,
    this.signOutTime,
  });

  // Method to convert AttendanceLog object to a Map
  Map<String, dynamic> toMap() {
    return {
      'signInTime': signInTime?.millisecondsSinceEpoch,
      'signOutTime': signOutTime?.millisecondsSinceEpoch,
    };
  }

  // Method to convert Map to AttendanceLog object
  factory AttendanceLog.fromMap(Map<String, dynamic> map) {
    return AttendanceLog(
      signInTime: map['signInTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['signInTime']) : null,
      signOutTime: map['signOutTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['signOutTime']) : null,
    );
  }
}
