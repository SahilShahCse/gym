import 'dart:convert';

class Trainer {
  String? id;
  String? name;
  String? contact;
  String? emailId;
  String? address;
  int? salary;
  String? shift;
  List<String>? personalTrainingId;
  String? gymCode;
  bool? isInGym; // New field for gym attendance status
  List<AttendanceLog>? attendanceLogs; // New field for attendance logs

  Trainer({
    this.id,
    this.name,
    this.contact,
    this.emailId,
    this.address,
    this.salary,
    this.shift,
    this.personalTrainingId,
    this.gymCode,
    this.isInGym,
    this.attendanceLogs,
  });

  // Method to convert Trainer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'emailId': emailId,
      'address': address,
      'salary': salary,
      'shift': shift,
      'personalTrainingId': personalTrainingId,
      'gymCode': gymCode,
      'isInGym': isInGym,
      'attendanceLogs': attendanceLogs?.map((log) => log.toMap()).toList(),
    };
  }

  // Method to convert Map to Trainer object
  factory Trainer.fromMap(Map<String, dynamic> map) {
    return Trainer(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
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