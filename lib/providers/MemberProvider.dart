import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/MemberModel.dart';

class MemberProvider extends ChangeNotifier {

  List<Member> _members = [];

  List<Member> get members => _members;

  final CollectionReference _membersCollection = FirebaseFirestore.instance.collection('members');

  Member? getMemberById(String id) {
    for (Member data in _members) {
      if (data.id == id) {
        return data;
      }
    }
    return null; // Return null if no member with the given id is found
  }

  List<Member> getMembersByTrainerId(String trainerId) {
    print('called');
    return _members.where((member) => member.trainerId == trainerId).toList();
  }

  Future<void> updateDiet(String memberId, List<Information> diet) async {
    try {
      await _membersCollection.doc(memberId).update({
        'diet': diet.map((workout) => workout.toMap()).toList(),
      });
      // Optionally, you can update the local data as well
      _members.forEach((member) {
        if (member.id == memberId) {
          member.diet = diet;
        }
      });
      notifyListeners();
    } catch (e) {
      print('Error updating workouts: $e');
      throw e;
    }
  }

  Future<void> updateWorkout(String memberId, List<Information> workouts) async {
    try {
      await _membersCollection.doc(memberId).update({
        'workout': workouts.map((workout) => workout.toMap()).toList(),
      });
      // Optionally, you can update the local data as well
      _members.forEach((member) {
        if (member.id == memberId) {
          member.workout = workouts; // Assuming you have a field named workouts in your Member model
        }
      });
      notifyListeners();
    } catch (e) {
      print('Error updating workouts: $e');
      throw e;
    }
  }

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
      _members.clear();
      _members.addAll(members);

      // Notify listeners of the change
      notifyListeners();

      // Listen to real-time updates
      _membersCollection
          .where('gymCode', isEqualTo: gymCode)
          .snapshots()
          .listen((snapshot) {
        // Convert the query snapshot to a list of Member objects
        List<Member> updatedMembers = snapshot.docs
            .map((doc) => Member.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        // Update the local _members list with the updated members
        _members.clear();
        _members.addAll(updatedMembers);

        // Notify listeners of the change
        notifyListeners();
      });
    } catch (e) {
      print('Error fetching members: $e');
      throw e;
    }

    print('data from firebase : ${_members.first.workout}');
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