import 'dart:convert';

class Payment {
  final String id;
  final String memberId;
  final double amount;
  final DateTime paymentDate;

  Payment({
    required this.id,
    required this.memberId,
    required this.amount,
    required this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      memberId: json['memberId'],
      amount: json['amount'],
      paymentDate: DateTime.parse(json['paymentDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      memberId: map['memberId'],
      amount: map['amount'],
      paymentDate: DateTime.parse(map['paymentDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberId': memberId,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory Payment.fromJsonString(String jsonString) {
    return Payment.fromJson(jsonDecode(jsonString));
  }

  static double calculateTotalPayments(List<Payment> payments) {
    double total = 0;
    for (var payment in payments) {
      total += payment.amount;
    }
    return total;
  }
}
