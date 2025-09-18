import 'package:flutter/material.dart';
import '../service/add_match_service.dart';
import '../models/match_model.dart';

class AddMatchRepo {
  final AddMatchService _addMatchService = AddMatchService();

  // Get Users List
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final users = await _addMatchService.fetchAllUsers();
      return users;
    } catch (e) {
      debugPrint("❌ Error fetching users list: $e");
      return [];
    }
  }

  // Insert a match
  Future<bool> addMatch(MatchModel match) async {
    try {
      return await _addMatchService.insertMatch(match);
    } catch (e) {
      debugPrint("❌ Error inserting match: $e");
      return false;
    }
  }
}
