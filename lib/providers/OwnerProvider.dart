import 'package:flutter/material.dart';
import '../models/MemberModel.dart';
import '../models/OwnerModel.dart';

class OwnerProvider extends ChangeNotifier {

  Owner _owner = Owner(
    id: '1',
    fullName: 'John Doe',
    email: 'john@example.com',
    password: 'password1',
    gymCode: 'Gym3',
    gymName: 'Fitness First',
    gymLocation: '123 Main Street',
  );

  Owner get owner => _owner;


  // Method to fetch members
  Future<void> fetchMembers() async {
    // Logic to fetch members from your data source (e.g., database, API)
    // Update _members with fetched data
    notifyListeners();
  }

  // Method to update member profile
  Future<void> updateMemberProfile(Member member) async {
    // Logic to update member profile in your data source
    notifyListeners();
  }
}
