import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;

  const CustomBottomNavBar({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.add, 'label': 'Add Match'},
      {'icon': Icons.star, 'label': 'Champions'},
      {'icon': Icons.history, 'label': 'History'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF191919),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191919).withAlpha((0.2 * 255).toInt()),
            blurRadius: 10,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == widget.selectedIndex;
          return GestureDetector(
            onTap: () => widget.onTabSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: isSelected ? 6 : 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.darkRedColor.withAlpha((0.2 * 255).toInt())
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.3 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    child: Icon(
                      item['icon'] as IconData,
                      color: isSelected ? Colors.white : AppColors.greyColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Text(
                      isSelected ? item['label'] as String : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
