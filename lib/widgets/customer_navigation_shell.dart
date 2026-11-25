import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../config/app_theme.dart';

class CustomerNavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomerNavigationShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final selected = navigationShell.currentIndex;
    final icons = [
      HugeIcons.strokeRoundedHome01,
      HugeIcons.strokeRoundedPackage,
      HugeIcons.strokeRoundedShoppingCart01,
      HugeIcons.strokeRoundedUser,
    ];
    final labels = ['Home', 'Orders', 'Cart', 'Profile'];
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              4,
              (i) => Expanded(
                child: _NavItem(
                  icon: icons[i],
                  label: labels[i],
                  selected: selected == i,
                  onTap: () => navigationShell.goBranch(
                    i,
                    initialLocation: i == selected,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(18),
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: selected ? 1.08 : 1,
            duration: const Duration(milliseconds: 220),
            child: HugeIcon(
              icon: icon,
              size: 22,
              color: selected ? AppTheme.primaryColor : AppTheme.textMuted,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? AppTheme.primaryColor : AppTheme.textMuted,
            ),
          ),
        ],
      ),
    ),
  );
}
