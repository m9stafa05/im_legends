import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/on_boarding_info.dart';
import 'on_boarding_custom_card.dart';

class OnBoardingGridCards extends StatelessWidget {
  const OnBoardingGridCards({
    super.key,
    this.showAllCards = false, // Option to show all cards or just featured ones
  });

  final bool showAllCards;

  @override
  Widget build(BuildContext context) {
    final cardsToShow = showAllCards
        ? OnBoardingInfo.cardsData
        : OnBoardingInfo.featuredCards;

    return GridView.builder(
      itemCount: cardsToShow.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.15, // Optimized for better card proportions
      ),
      itemBuilder: (context, index) {
        final card = cardsToShow[index];
        return OnBoardingCustomCard(
          title: card.title,
          subTitle: card.subTitle,
          icon: card.icon,
          gradient: card.gradient,
        );
      },
    );
  }
}
