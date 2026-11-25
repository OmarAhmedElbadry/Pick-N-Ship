import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_theme.dart';
import '../models/shop_model.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shop;
  final VoidCallback onTap;

  const ShopCard({super.key, required this.shop, required this.onTap});

  IconData get _icon {
    switch (shop.category) {
      case 'grocery':
        return Icons.shopping_basket_outlined;
      case 'fish':
        return Icons.set_meal_outlined;
      case 'meat':
        return Icons.restaurant_outlined;
      case 'vegetables':
        return Icons.eco_outlined;
      case 'pharmacy':
        return Icons.medication_outlined;
      case 'parcel_pickup':
        return Icons.inventory_2_outlined;
      default:
        return Icons.storefront_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 76,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1F1),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: shop.logoUrl.isNotEmpty || shop.imageUrl.isNotEmpty
                    ? Image.network(
                        shop.logoUrl.isNotEmpty ? shop.logoUrl : shop.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _fallbackIcon,
                      )
                    : _fallbackIcon,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.shopName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shop.addressText.isEmpty
                          ? shop.description
                          : shop.addressText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 7,
                      runSpacing: 5,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: AppTheme.primaryColor,
                        ),
                        Text(
                          shop.rating.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark,
                          ),
                        ),
                        _dot,
                        Text(
                          shop.category.replaceAll('_', ' '),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppTheme.secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        _dot,
                        Text(
                          shop.isOpen ? 'Open' : 'Closed',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: shop.isOpen
                                    ? AppTheme.successGreen
                                    : AppTheme.errorRed,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppTheme.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _fallbackIcon =>
      Center(child: Icon(_icon, size: 31, color: AppTheme.primaryColor));

  static const Widget _dot = Icon(
    Icons.circle,
    size: 3,
    color: AppTheme.textMuted,
  );
}
