import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../profile/logic/cubit/profile_cubit.dart';
import '../../../history/logic/cubit/match_history_cubit.dart';
import '../../../home/logic/cubit/leader_board_cubit.dart';
import '../../data/models/match_model.dart';
import '../../logic/cubit/add_match_cubit.dart';
import 'add_match_button.dart';

class AddMatchBlocConsumer extends StatelessWidget {
  const AddMatchBlocConsumer({
    super.key,
    required bool isAddButtonEnabled,
    required this.winnerPlayer,
    required this.loserPlayer,
    required this.winnerScore,
    required this.loserScore,
  }) : _isAddButtonEnabled = isAddButtonEnabled;

  final bool _isAddButtonEnabled;
  final String? winnerPlayer;
  final String? loserPlayer;
  final int winnerScore;
  final int loserScore;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMatchCubit, AddMatchState>(
      listener: (context, state) {
        if (state is AddMatchInsertSuccess) {
          //  Show success dialog
          SuccessMessage(context);
          // Trigger refresh in other cubits
          context.read<LeaderBoardCubit>().loadLeaderboard();
          context.read<MatchHistoryCubit>().getMatchHistory();
          context.read<ProfileCubit>().fetchProfile();
        } else if (state is AddMatchFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddMatchLoading;

        return AddMatchButton(
          isEnabled: _isAddButtonEnabled,
          isLoading: isLoading,
          onPressed: _isAddButtonEnabled
              ? () {
                  final match = MatchModel(
                    winnerId: winnerPlayer!,
                    loserId: loserPlayer!,
                    winnerScore: winnerScore,
                    loserScore: loserScore,
                  );
                  // call cubit
                  context.read<AddMatchCubit>().addMatch(match);
                }
              : null,
        );
      },
    );
  }

  Future<dynamic> SuccessMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Success',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Match added successfully!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
