import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'player_tile.dart';
import '../../../../../core/themes/app_texts_style.dart';

class PlayerBottomSheet extends StatelessWidget {
  final List<String> players;
  final String? selectedPlayer;
  final void Function(String) onSelect;
  final String? excludedPlayer;

  const PlayerBottomSheet({
    super.key,
    required this.players,
    required this.selectedPlayer,
    required this.onSelect,
    this.excludedPlayer,
  });

  @override
  Widget build(BuildContext context) {
    // Filter out the excluded player
    final filteredPlayers = players
        .where((player) => player != excludedPlayer)
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1D26), Color(0xFF141620)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.6 * 255).toInt()),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHandleBar(),
          _buildHeader(context, filteredPlayers),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = filteredPlayers[index];
                final isSelected = selectedPlayer == player;
                return PlayerTile(
                  player: player,
                  isSelected: isSelected,
                  index: index,
                  onSelect: onSelect,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandleBar() => Container(
    margin: EdgeInsets.only(top: 12.h),
    width: 40.w,
    height: 4.h,
    decoration: BoxDecoration(
      color: Colors.white.withAlpha((0.15 * 255).toInt()),
      borderRadius: BorderRadius.circular(2.r),
    ),
  );

  Widget _buildHeader(BuildContext context, List<String> filteredPlayers) =>
      Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(Icons.sports_esports_rounded, color: Colors.blue, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'Choose Player',
              style: BebasTextStyles.whiteBold20.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              '${filteredPlayers.length} players',
              style: TextStyle(
                color: Colors.white.withAlpha((0.6 * 255).toInt()),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      );
}
