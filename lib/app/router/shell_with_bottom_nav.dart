import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/v2/fk_app_background.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';

/// Persistent shell that shows the bottom nav bar on home, community, events, and profile tabs.
class ShellWithBottomNav extends StatelessWidget {
  const ShellWithBottomNav({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  final StatefulNavigationShell navigationShell;
  final GoRouterState state;

  static int _selectedIndexForPath(String path) {
    if (path.startsWith('/community')) return 1;
    if (path.startsWith('/events')) return 2;
    if (path.startsWith('/blogs')) return 3;
    if (path.startsWith('/profile')) return 4;
    return 0; // /home or default
  }

  BottomNavigationBarItem _navItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: AppColors.unselectedNavBarIconColor),
      activeIcon: Icon(icon, color: AppColors.selectedNavBarIconColor),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final path = state.uri.path;
    final currentIndex = _selectedIndexForPath(path);
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return FkAppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navigationShell,
        bottomNavigationBar: isKeyboardVisible
            ? null
            : Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: BottomNavigationBar(
                  backgroundColor: AppColors.navBarBackgroundColorV2,
                  elevation: 0,
                  currentIndex: currentIndex,
                  onTap: (index) => navigationShell.goBranch(index),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: AppColors.selectedNavBarIconColor,
                  unselectedItemColor: AppColors.unselectedNavBarIconColor,
                  unselectedLabelStyle: textStyle_12MediumGrey(),
                  selectedLabelStyle: textStyle_12MediumGrey(),
                  items: [
                    _navItem(icon: Icons.home_rounded, label: 'Home'),
                    _navItem(icon: Icons.groups_rounded, label: 'Community'),
                    _navItem(icon: Icons.event_rounded, label: 'Events'),
                    _navItem(icon: Icons.article_rounded, label: 'Blogs'),
                    _navItem(icon: Icons.person_rounded, label: 'Profile'),
                  ],
                ),
              ),
      ),
    );
  }
}
