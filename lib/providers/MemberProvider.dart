import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/MemberModel.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> _members = [];
  late Member _member;

  List<Member> get members => _members;
  Member get member => _member;

  final CollectionReference _membersCollection =
  FirebaseFirestore.instance.collection('members');

  Future<void> setMember(Member newMember) async {
    try {
      // Add a new document to the members collection with auto-generated ID
      DocumentReference newMemberRef =
      await _membersCollection.add(newMember.toMap());

      // Retrieve the auto-generated ID and store it in the newMember object
      String memberId = newMemberRef.id;
      newMember.id = memberId;

      // Update the document in Firestore with the newMember object containing the ID
      await newMemberRef.set(newMember.toMap());

      // Add the newMember to the local _members list
      _members.add(newMember);

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      print('Error setting new member: $e');
      throw e;
    }
  }

  Future<void> updatePaymentRecord(String memberId, PaymentRecord paymentRecord) async {
    try {
      // Get the document reference for the member
      DocumentReference memberRef = _membersCollection.doc(memberId);

      // Add the payment record to the member's paymentRecords array
      await memberRef.update({
        'paymentRecords': FieldValue.arrayUnion([paymentRecord.toMap()]),
      });

      // Optionally, you can update the local data as well if needed

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      print('Error updating payment record: $e');
      throw e;
    }
  }

  Member? getMemberById(String id) {
    for (Member data in _members) {
      if (data.id == id) {
        return data;
      }
    }
    return null; // Return null if no member with the given id is found
  }

  Future<void> updateMemberPaymentStatus(String memberId, bool isPaid) async {}

  List<Member> getMembersByTrainerId(String trainerId) {
    return _members
        .where((member) => member.trainerId == trainerId)
        .toList();
  }

  Future<void> updateDiet(String memberId, List<Information> diet) async {
    try {
      await _membersCollection.doc(memberId).update({
        'diet': diet.map((workout) => workout.toMap()).toList(),
      });
      _members.forEach((member) {
        if (member.id == memberId) {
          member.diet = diet;
        }
      });
      notifyListeners();
    } catch (e) {
      print('Error updating diet: $e');
      throw e;
    }
  }

  Future<void> updateWorkout(String memberId, List<Information> workouts) async {
    try {
      await _membersCollection.doc(memberId).update({
        'workout': workouts.map((workout) => workout.toMap()).toList(),
      });
      _members.forEach((member) {
        if (member.id == memberId) {
          member.workout = workouts;
        }
      });
      notifyListeners();
    } catch (e) {
      print('Error updating workouts: $e');
      throw e;
    }
  }

  Future<void> fetchMembersByGymCode(String gymCode) async {
    try {
      _members.clear();

      QuerySnapshot querySnapshot =
      await _membersCollection.where('gymCode', isEqualTo: gymCode).get();

      List<Member> members = querySnapshot.docs
          .map((doc) => Member.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      _members.clear();
      _members.addAll(members);

      notifyListeners();

      _membersCollection
          .where('gymCode', isEqualTo: gymCode)
          .snapshots()
          .listen((snapshot) {
        List<Member> updatedMembers = snapshot.docs
            .map((doc) => Member.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        _members.clear();
        _members.addAll(updatedMembers);

        notifyListeners();
      });
    } catch (e) {
      print('Error fetching members: $e');
      throw e;
    }
  }

  Future<void> updateMemberProfile(Member member) async {
    try {
      await _membersCollection.doc(member.id).update(member.toMap());
      _members.removeWhere((m) => m.id == member.id);
      _members.add(member);
      notifyListeners();
    } catch (e) {
      print('Error updating member profile: $e');
      throw e;
    }
  }

  Future<List<Member>> getMembersWithFeesPending() async {
    try {
      QuerySnapshot querySnapshot =
      await _membersCollection.where('feesPaid', isEqualTo: false).get();
      return querySnapshot.docs
          .map((doc) => Member.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting members with fees pending: $e');
      throw e;
    }
  }

  Future<List<Member>> getMembersWithFeesPaid() async {
    try {
      QuerySnapshot querySnapshot =
      await _membersCollection.where('feesPaid', isEqualTo: true).get();
      return querySnapshot.docs
          .map((doc) => Member.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting members with fees paid: $e');
      throw e;
    }
  }

  Future<List<Member>> getMembersWithMembershipExpired() async {
    try {
      QuerySnapshot querySnapshot = await _membersCollection
          .where('membershipExpiryDate', isLessThan: DateTime.now())
          .get();
      return querySnapshot.docs
          .map((doc) => Member.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting members with membership expired: $e');
      throw e;
    }
  }

  Future<List<PaymentRecord>> getMemberPaymentRecord(String memberId) async {
    try {
      DocumentSnapshot doc =
      await _membersCollection.doc(memberId).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('paymentRecords')) {
        List<dynamic> records = data['paymentRecords'];
        return records
            .map((record) => PaymentRecord.fromMap(record))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting payment records for member: $e');
      throw e;
    }
  }
}