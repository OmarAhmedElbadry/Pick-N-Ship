import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/currency.dart';
import '../../config/app_router.dart';
import '../../config/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/shop_provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/category_card.dart';
import '../../widgets/shop_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShopProvider>().loadShops();
      final uid = context.read<AuthProvider>().uid;
      if (uid.isNotEmpty) {
        context.read<OrderProvider>().startListeningToMyOrders(uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final cart = context.watch<CartProvider>();
    final firebaseUser = AuthService().currentUser;
    final photoUrl = firebaseUser?.photoURL;
    final name = auth.user?.name.trim() ?? '';

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppTheme.hairline),
                      ),
                      child: const Icon(
                        Icons.grid_view_rounded,
                        size: 21,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOCAL DELIVERY',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: AppTheme.primaryColor,
                              ),
                              const SizedBox(width: 3),
                              Flexible(
                                child: Text(
                                  auth.user?.address.isNotEmpty == true
                                      ? auth.user!.address
                                      : 'Set your address',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.textDark,
                                      ),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 17,
                                color: AppTheme.textMuted,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Notifications',
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: AppTheme.hairline),
                        fixedSize: const Size(42, 42),
                      ),
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 9),
                    GestureDetector(
                      onTap: () => _showProfileMenu(context),
                      child: CircleAvatar(
                        radius: 21,
                        backgroundColor: const Color(0xFFE6E7E8),
                        backgroundImage: photoUrl == null
                            ? null
                            : NetworkImage(photoUrl),
                        child: photoUrl == null
                            ? Text(
                                name.isEmpty ? 'U' : name[0].toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primaryColor,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 27, 22, 0),
              sliver: SliverToBoxAdapter(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 550),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 12 * (1 - value)),
                      child: child,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi${name.isEmpty ? '' : ', $name'},',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'What do you need\ntoday?',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 21, 22, 0),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  onChanged: context.read<ShopProvider>().searchShops,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search shops or products',
                    prefixIcon: const Icon(Icons.search_rounded, size: 22),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 27, 22, 13),
              sliver: SliverToBoxAdapter(
                child: _sectionHeader(context, 'Browse categories'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 105,
                child: Consumer<ShopProvider>(
                  builder: (context, provider, _) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    itemCount: ShopProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = ShopProvider.categories[index];
                      return CategoryCard(
                        label: category['label']!,
                        icon: category['icon']!,
                        isSelected:
                            provider.selectedCategory == category['key'],
                        onTap: () => provider.selectCategory(category['key']!),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 27, 22, 14),
              sliver: SliverToBoxAdapter(
                child: Consumer<ShopProvider>(
                  builder: (context, provider, _) {
                    final selected = ShopProvider.categories.firstWhere(
                      (item) => item['key'] == provider.selectedCategory,
                      orElse: () => ShopProvider.categories.first,
                    );
                    return _sectionHeader(
                      context,
                      provider.selectedCategory == 'all'
                          ? 'Nearby shops'
                          : '${selected['label']} shops',
                      trailing: provider.shops.isEmpty
                          ? null
                          : '${provider.shops.length} places',
                    );
                  },
                ),
              ),
            ),
            Consumer<ShopProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
                if (provider.errorMessage != null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: _emptyState(
                      context,
                      icon: Icons.wifi_off_rounded,
                      title: 'Could not load shops',
                      subtitle: provider.errorMessage!,
                      action: 'Try again',
                      onPressed: provider.loadShops,
                    ),
                  );
                }
                if (provider.shops.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: _emptyState(
                      context,
                      icon: Icons.storefront_outlined,
                      title: 'No shops found',
                      subtitle: 'Try another category or search term.',
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
                  sliver: SliverList.builder(
                    itemCount: provider.shops.length,
                    itemBuilder: (context, index) {
                      final shop = provider.shops[index];
                      return TweenAnimationBuilder<double>(
                        key: ValueKey(shop.shopId),
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(
                          milliseconds: 280 + (index.clamp(0, 5).toInt() * 65),
                        ),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 14 * (1 - value)),
                            child: child,
                          ),
                        ),
                        child: ShopCard(
                          shop: shop,
                          onTap: () =>
                              context.push(AppRouter.shopDetail, extra: shop),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: cart.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.go(AppRouter.cart),
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 4,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(
                '${cart.totalQuantity} items · ${formatEgp(cart.subtotal)}',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    String title, {
    String? trailing,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
      ],
    );
  }

  Widget _emptyState(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    String? action,
    VoidCallback? onPressed,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: AppTheme.textMuted),
            ),
            const SizedBox(height: 15),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (action != null) ...[
              const SizedBox(height: 18),
              OutlinedButton(onPressed: onPressed, child: Text(action)),
            ],
          ],
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    final auth = context.read<AuthProvider>();
    final user = AuthService().currentUser;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 6, 22, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              CircleAvatar(
                radius: 34,
                backgroundColor: const Color(0xFFE9EAEB),
                backgroundImage: user?.photoURL == null
                    ? null
                    : NetworkImage(user!.photoURL!),
                child: user?.photoURL == null
                    ? Text(
                        (auth.user?.name.isNotEmpty == true
                                ? auth.user!.name[0]
                                : 'U')
                            .toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 10),
              Text(
                auth.user?.name ?? 'User',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                auth.user?.phone ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 18),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: const Text('Edit profile'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.push(AppRouter.profile);
                },
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('My orders'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.go(AppRouter.orderHistory);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text('Log out'),
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await auth.signOut();
                  if (context.mounted) {
                    context.go(AppRouter.login);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
