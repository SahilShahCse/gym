import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/TrainerModel.dart';

class TrainerProvider extends ChangeNotifier {
  List<Trainer> _trainers = [];

  List<Trainer> get trainers => _trainers;

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

  Future<void> addTrainer(Trainer trainer) async {
    try {
      // Add a new document to the trainers collection with auto-generated ID
      DocumentReference newTrainerRef = await _trainersCollection.add(trainer.toMap());

      // Retrieve the auto-generated ID and store it in the trainer object
      String trainerId = newTrainerRef.id;
      trainer.id = trainerId;

      // Update the document in Firestore with the trainer object containing the ID
      await newTrainerRef.set(trainer.toMap());

      // Update the local _trainers list with the newly added trainer
      _trainers.add(trainer);

      // Notify listeners of the change
      notifyListeners();
    } catch (e) {
      print('Error adding trainer: $e');
      throw e;
    }
  }

  // Method to fetch trainers
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

  // Method to update trainer profile
  Future<void> updateTrainerProfile(Trainer trainer) async {
    // Logic to update trainer profile in your data source
    notifyListeners();
  }

  // Method to update trainer's shift
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
}
