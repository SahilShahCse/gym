import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/OwnerModel.dart';
import '../models/TrainerModel.dart';

class TrainerProvider extends ChangeNotifier {

  List<Owner> _trainers = [];

  final CollectionReference _trainersCollection = FirebaseFirestore.instance.collection('trainers');

  Future<void> addTrainer(Trainer trainer) async {
    try {
      // Add a new document to the trainers collection with auto-generated ID
      DocumentReference newTrainerRef = await _trainersCollection.add(trainer.toMap());

      // Retrieve the auto-generated ID and store it in the trainer object
      String trainerId = newTrainerRef.id;
      trainer.id = trainerId;

      // Update the document in Firestore with the trainer object containing the ID
      await newTrainerRef.set(trainer.toMap());
    } catch (e) {
      print('Error adding trainer: $e');
      throw e;
    }
  }

  // Method to fetch trainers
  Future<void> fetchTrainers() async {
    // Logic to fetch trainers from your data source (e.g., database, API)
    // Update _trainers with fetched data
    notifyListeners();
  }

  // Method to update trainer profile
  Future<void> updateTrainerProfile(Owner trainer) async {
    // Logic to update trainer profile in your data source
    notifyListeners();
  }
}