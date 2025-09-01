import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../router/routes.dart';
import 'custom_bottom_navigation_bar.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int _previousIndex = 0;
  bool _isNavigating = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final tabs = [
    Routes.homeScreen,
    Routes.addMatchScreen,
    Routes.championsScreen,
    Routes.historyScreen,
    Routes.profileScreen,
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Fade animation for smooth transitions
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Slide animation for page transitions
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Scale animation for subtle zoom effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Start with animations ready
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  void _onTabSelected(int index) async {
    if (_selectedIndex != index && !_isNavigating) {
      setState(() {
        _isNavigating = true;
        _previousIndex = _selectedIndex;
        _selectedIndex = index;
      });

      // Determine slide direction based on tab position
      final slideDirection = index > _previousIndex
          ? const Offset(1.0, 0.0) // Slide from right
          : const Offset(-1.0, 0.0); // Slide from left

      // Update slide animation direction
      _slideAnimation = Tween<Offset>(begin: slideDirection, end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _slideController,
              curve: Curves.easeOutCubic,
            ),
          );

      // Animate out current page
      await Future.wait([
        _fadeController.reverse(),
        _scaleController.reverse(),
      ]);

      // Navigate to new route
      if (mounted) {
        GoRouter.of(context).go(tabs[index]);
      }

      // Small delay to ensure route change
      await Future.delayed(const Duration(milliseconds: 50));

      // Reset slide controller and animate in new page
      if (mounted) {
        _slideController.reset();
        await Future.wait([
          _slideController.forward(),
          _fadeController.forward(),
          _scaleController.forward(),
        ]);

        setState(() {
          _isNavigating = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated page content
          AnimatedBuilder(
            animation: Listenable.merge([
              _fadeAnimation,
              _slideAnimation,
              _scaleAnimation,
            ]),
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: widget.child,
                  ),
                ),
              );
            },
          ),

          // Loading overlay during navigation
          if (_isNavigating)
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              color: Colors.black.withAlpha((0.5 * 255).toInt()),
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),

      // Enhanced bottom navigation with haptic feedback
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black..withAlpha((0.5 * 255).toInt()),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onTabSelected: (index) {
            // Add haptic feedback
            HapticFeedback.selectionClick();
            _onTabSelected(index);
          },
        ),
      ),
    );
  }
}
