import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/MemberModel.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> _members = [];

  List<Member> get members => _members;

  final CollectionReference _membersCollection =
  FirebaseFirestore.instance.collection('members');

  Future<void> addMember(Member member) async {
    try {
      // Add a new document to the members collection with auto-generated ID
      DocumentReference newMemberRef =
      await _membersCollection.add(member.toMap());

      // Retrieve the auto-generated ID and store it in the member object
      String memberId = newMemberRef.id;
      member.id = memberId;

      // Update the document in Firestore with the member object containing the ID
      await newMemberRef.set(member.toMap());

      // Update the local _members list with the newly added member
      _members.add(member);

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      print('Error adding member: $e');
      throw e;
    }
  }

  // Method to fetch members with a given gym code
  Future<void> fetchMembersByGymCode(String gymCode) async {
    try {
      // Clear the existing list of members
      _members.clear();

      // Query Firestore to get all members with the given gym code
      QuerySnapshot querySnapshot = await _membersCollection
          .where('gymCode', isEqualTo: gymCode)
          .get();

      // Convert the query snapshot to a list of Member objects
      List<Member> members = querySnapshot.docs
          .map((doc) => Member.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Update the local _members list with the fetched members
      _members.addAll(members);

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      print('Error fetching members: $e');
      throw e;
    }
  }

  // Method to update member profile
  Future<void> updateMemberProfile(Member member) async {
    // Logic to update member profile in your data source
    notifyListeners();
  }

// Method to update member's payment status
  Future<void> updateMemberPaymentStatus(String memberId, bool isPaid) async {
    try {
      // Update the payment status in Firestore
      await _membersCollection.doc(memberId).update({'isPaid': isPaid});

      // Update the payment status locally
      _members.forEach((member) {
        if (member.id == memberId) {
          member.isPaid = isPaid;
        }
      });

      notifyListeners();
    } catch (e) {
      print('Error updating member payment status: $e');
      throw e;
    }
  }

}
