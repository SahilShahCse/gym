import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/models/MemberModel.dart';
import '../models/TrainerModel.dart';

class TrainerProvider extends ChangeNotifier {
  List<Trainer> _trainers = [];
  late Trainer _trainer;

  List<Trainer> get trainers => _trainers;
  Trainer get trainer => _trainer;

  final CollectionReference _trainersCollection =
  FirebaseFirestore.instance.collection('trainers');

  Trainer? getTrainerById(String id) {
    for (Trainer data in _trainers) {
      if (data.id == id) {
        return data;
      }
    }
    return null; // Return null if no trainer with the given id is found
  }

  Future<void> fetchTrainersByGymCode(String gymCode) async {
    try {
      // Clear the existing list of trainers
      _trainers.clear();

      // Query Firestore to get trainers with the specified gymCode
      QuerySnapshot querySnapshot = await _trainersCollection
          .where('gymCode', isEqualTo: gymCode)
          .get();

      // Convert the query snapshot to a list of Trainer objects
      List<Trainer> trainers = querySnapshot.docs
          .map((doc) => Trainer.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Update the local _trainers list with the fetched trainers
      _trainers.addAll(trainers);

      // Notify listeners of the change
      notifyListeners();

      // Listen to real-time updates
      _trainersCollection
          .where('gymCode', isEqualTo: gymCode)
          .snapshots()
          .listen((snapshot) {
        // Convert the query snapshot to a list of Trainer objects
        List<Trainer> updatedTrainers = snapshot.docs
            .map((doc) => Trainer.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        // Update the local _trainers list with the updated trainers
        _trainers.clear();
        _trainers.addAll(updatedTrainers);
        print('fetching $updatedTrainers');
        // Notify listeners of the change
        notifyListeners();
      });
    } catch (e) {
      print('Error fetching trainers: $e');
      throw e;
    }
  }

  Future<void> updateTrainerMobileNumberPermission(String trainerId, bool canSeeMobileNumbers) async {
    final trainerIndex = _trainers.indexWhere((trainer) => trainer.id == trainerId);
    if (trainerIndex != -1) {
      _trainers[trainerIndex].canSeeMobileNumbers = canSeeMobileNumbers;
      notifyListeners();

      // Update the data on Firebase Firestore
     await  _trainersCollection.doc(trainerId).set({
        'canSeeMobileNumbers': canSeeMobileNumbers,
      }, SetOptions(merge: true)).then((_) {
        print('Trainer mobile number permission updated on Firestore');
      }).catchError((error) {
        print('Failed to update trainer mobile number permission: $error');
      });
    }
  }

  Future<void> updateTrainerPaymentStatusPermission(String trainerId, bool canUpdatePaymentStatus) async {
    final trainerIndex = _trainers.indexWhere((trainer) => trainer.id == trainerId);
    if (trainerIndex != -1) {
      _trainers[trainerIndex].canUpdatePaymentStatus = canUpdatePaymentStatus;

      notifyListeners();

      // Update the data on Firebase Firestore
      await _trainersCollection.doc(trainerId).set({
        'canUpdatePaymentStatus': canUpdatePaymentStatus,
      }, SetOptions(merge: true)).then((_) {
        print('Trainer payment status permission updated on Firestore');
      }).catchError((error) {
        print('Failed to update trainer payment status permission: $error');
      });
    }
  }


  Future<void> toggleGymAttendance(String trainerId, bool isInGym) async {
    try {
      // Update the gym attendance status in Firestore
      _trainersCollection.doc(trainerId).update({'isInGym': isInGym});

      // Update the local trainer object
      trainer.isInGym = isInGym;
      notifyListeners();
    } catch (e) {
      print('Error toggling gym attendance: $e');
      throw e;
    }
  }

  Future<void> updateTrainerShift(String trainerId, String shift) async {
    try {
      // Update the shift in Firestore
      await _trainersCollection.doc(trainerId).update({'shift': shift});

      // Update the shift locally
      _trainers.forEach((trainer) {
        if (trainer.id == trainerId) {
          trainer.shift = shift;
        }
      });

      notifyListeners();
    } catch (e) {
      print('Error updating trainer shift: $e');
      throw e;
    }
  }

  void setTrainer(Trainer trainer) {
    _trainer = trainer;
    notifyListeners();
  }
}
