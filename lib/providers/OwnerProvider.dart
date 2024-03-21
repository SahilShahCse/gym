import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym/models/TrainerModel.dart';
import '../models/MemberModel.dart';
import '../models/OwnerModel.dart';

class OwnerProvider extends ChangeNotifier {

  late Owner _owner;
  Owner get owner => _owner;

  final CollectionReference _ownersCollection =
  FirebaseFirestore.instance.collection('owners');



  void setOwner(Owner owner) async {
      _owner = owner;

      notifyListeners();
  }

  Future<void> getOwner(String ownerId) async {
    try {
      // Fetch owner document from Firestore
      DocumentSnapshot ownerDoc =
      await _ownersCollection.doc(ownerId).get();

      if (ownerDoc.exists) {
        // If owner document exists, create Owner object from data
        Map<String, dynamic> ownerData = ownerDoc.data() as Map<String, dynamic>;
        Owner owner = Owner.fromMap(ownerData);

        // Set owner data locally
        _owner = owner;

        // Notify listeners of the change
        notifyListeners();
      } else {
        throw Exception("Owner not found");
      }
    } catch (e) {
      print('Error getting owner: $e');
      throw e;
    }
  }

}
