/// ============================================================
/// splash_screen.dart — App Launch Screen
/// ============================================================
/// Shown briefly on app start. Checks if the user is already
/// authenticated and routes accordingly:
///   - Logged in + has profile → Home
///   - Logged in + no profile  → Profile Setup
///   - Not logged in           → Login
/// ============================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../config/app_router.dart';
import '../config/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    // Fade-in + scale animation for the logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnim = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();

    // Check auth state after a brief delay
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool('has_seen_onboarding') ?? false)) {
      if (mounted) context.go(AppRouter.onboarding);
      return;
    }

    final authProvider = context.read<AuthProvider>();
    await authProvider.checkAuthState();

    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      if (authProvider.isNewUser) {
        context.go(AppRouter.profileSetup);
      } else {
        // Route based on user role
        final role = authProvider.user?.role ?? 'customer';
        if (role == 'rider') {
          context.go(AppRouter.riderHome);
        } else if (role == 'admin') {
          context.go(AppRouter.adminDashboard);
        } else {
          context.go(AppRouter.home);
        }
      }
    } else {
      context.go(AppRouter.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: AppTheme.bgLight),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppTheme.hairline),
                  ),
                  child: Center(
                    child: Text(
                      '07',
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // App Name
                Text(
                  'Local Delivery',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),

                // Tagline
                Text(
                  'Hyperlocal Delivery in Your Neighborhood',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 40),

                /// Loading indicator
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
