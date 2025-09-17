import 'package:flutter/material.dart';
import '../service/add_match_service.dart';

class AddMatchRepo {
  final AddMatchService _addMatchService = AddMatchService();

  // Get Users List
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final users = await _addMatchService.fetchAllUsers(); // ✅ call the method
      return users;
    } catch (e) {
      debugPrint("❌ Error fetching users list: $e");
      return [];
    }
  }
}
