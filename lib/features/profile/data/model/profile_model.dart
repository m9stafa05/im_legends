import 'package:im_legends/core/models/players_states_model.dart';
import 'package:im_legends/core/models/user_data.dart';

class UserProfileModel {
  final UserData user;
  final PlayerStatsModel stats;

  UserProfileModel({required this.user, required this.stats});
}
