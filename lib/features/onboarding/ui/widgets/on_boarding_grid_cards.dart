import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/on_boarding_info.dart';
import 'on_boarding_custom_card.dart';

class OnBoardingGridCards extends StatelessWidget {
  const OnBoardingGridCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: OnBoardingInfo.cardsData.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 40.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 1.4, // Better control over item dimensions
      ),
      itemBuilder: (context, index) {
        final card = OnBoardingInfo.cardsData[index];
        return OnBoardingCustomCard(title: card.title, subTitle: card.subTitle);
      },
    );
  }
}
