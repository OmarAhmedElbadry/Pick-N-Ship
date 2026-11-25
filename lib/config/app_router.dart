import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/shop_model.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/profile_setup_screen.dart';
import '../screens/customer/home_screen.dart';
import '../screens/customer/shop_detail_screen.dart';
import '../screens/customer/cart_screen.dart';
import '../screens/customer/checkout_screen.dart';
import '../screens/customer/order_confirmation_screen.dart';
import '../screens/customer/order_history_screen.dart';
import '../screens/rider/rider_home_screen.dart';
import '../screens/customer/order_tracking_screen.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/profile_screen.dart';
import '../widgets/customer_navigation_shell.dart';

class AppRouter {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const otp = '/otp';
  static const profileSetup = '/profile-setup';
  static const home = '/home';
  static const riderHome = '/rider-home';
  static const shopDetail = '/shop-detail';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orderConfirmation = '/order-confirmation';
  static const orderHistory = '/orders';
  static const orderTracking = '/track';
  static const adminDashboard = '/admin-dashboard';
  static const profile = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        pageBuilder: (_, state) => _page(state, const SplashScreen()),
      ),
      GoRoute(
        path: onboarding,
        pageBuilder: (_, state) => _page(state, const OnboardingScreen()),
      ),
      GoRoute(
        path: login,
        pageBuilder: (_, state) => _page(state, const LoginScreen()),
      ),
      GoRoute(
        path: otp,
        pageBuilder: (_, state) => _page(state, const OTPScreen()),
      ),
      GoRoute(
        path: profileSetup,
        pageBuilder: (_, state) => _page(state, const ProfileSetupScreen()),
      ),
      GoRoute(
        path: riderHome,
        pageBuilder: (_, state) => _page(state, const RiderHomeScreen()),
      ),
      GoRoute(
        path: adminDashboard,
        pageBuilder: (_, state) => _page(state, const AdminDashboard()),
      ),
      GoRoute(
        path: profile,
        pageBuilder: (_, state) => _page(state, const ProfileScreen()),
      ),
      GoRoute(
        path: shopDetail,
        pageBuilder: (_, state) =>
            _page(state, ShopDetailScreen(shop: state.extra as ShopModel?)),
      ),
      GoRoute(
        path: checkout,
        pageBuilder: (_, state) => _page(state, const CheckoutScreen()),
      ),
      GoRoute(
        path: '/order-confirmation',
        pageBuilder: (_, state) =>
            _page(state, const OrderConfirmationScreen()),
      ),
      GoRoute(
        path: '/track/:orderId',
        pageBuilder: (_, state) => _page(
          state,
          OrderTrackingScreen(orderId: state.pathParameters['orderId']!),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, state, shell) =>
            CustomerNavigationShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                pageBuilder: (_, state) => _page(state, const HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: orderHistory,
                pageBuilder: (_, state) =>
                    _page(state, const OrderHistoryScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: cart,
                pageBuilder: (_, state) => _page(state, const CartScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                pageBuilder: (_, state) => _page(state, const ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage<void> _page(GoRouterState state, Widget child) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionDuration: const Duration(milliseconds: 280),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        transitionsBuilder: (_, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, .025),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: child,
              ),
            ),
      );
}
