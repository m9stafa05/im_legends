import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'widgets/home_header_container.dart';
import 'widgets/leader_board_list_view.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomAppBar(title: 'Leaderboard'),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  HomeHeaderContainer(
                    onCreateMatch: () => context.go(RoutePaths.addMatch),
                  ),
                  verticalSpacing(16),
                  const LeadBoardListView(shrinkWrap: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
