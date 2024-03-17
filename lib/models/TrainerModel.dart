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

  Trainer({
    this.id,
    this.name,
    this.contact,
    this.emailId,
    this.address,
    this.salary,
    this.shift,
    this.personalTrainingId,
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
    );
  }

  // Method to convert Trainer object to JSON string
  String toJson() => json.encode(toMap());

  // Method to convert JSON string to Trainer object
  factory Trainer.fromJson(String source) => Trainer.fromMap(json.decode(source));
}
