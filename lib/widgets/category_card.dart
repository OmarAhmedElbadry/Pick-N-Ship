import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  IconData get _categoryIcon {
    switch (icon) {
      case '🏪':
        return Icons.storefront_outlined;
      case '🛒':
        return Icons.shopping_basket_outlined;
      case '🐟':
        return Icons.set_meal_outlined;
      case '🥩':
        return Icons.restaurant_outlined;
      case '🥬':
        return Icons.eco_outlined;
      case '💊':
        return Icons.medication_outlined;
      case '📦':
        return Icons.inventory_2_outlined;
      default:
        return Icons.storefront_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          width: 88,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppTheme.primaryColor : AppTheme.hairline,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.06 : 1,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutBack,
                child: Icon(
                  _categoryIcon,
                  size: 30,
                  color: AppTheme.primaryColor,
                  weight: 1.4,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textDark,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
