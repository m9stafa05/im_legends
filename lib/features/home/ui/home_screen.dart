import 'package:flutter/material.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/spacing.dart';
import 'widgets/home_header_container.dart';
import 'widgets/leader_board_list_view.dart';
import '../../../core/router/routes.dart';
import '../../../core/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Leaderboard'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeHeaderContainer(
                    userName: 'Mustafa',
                    onCreateMatch: () =>
                        context.pushNamed(Routes.addMatchScreen),
                  ),
                  verticalSpacing(20),
                  LeadBoardListView(), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
