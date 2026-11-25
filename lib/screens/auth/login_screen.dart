import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/app_router.dart';
import '../../config/app_theme.dart';
import '../../config/demo_data.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedRole = 'customer';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    final national = digits.startsWith('0') ? digits.substring(1) : digits;
    await context.read<AuthProvider>().sendOTP(
      '+20$national',
      _selectedRole,
      onSuccess: () {
        if (mounted) context.push(AppRouter.otp);
      },
      onError: (message) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }

  Future<void> _googleSignIn() async {
    final auth = context.read<AuthProvider>();
    await auth.signInWithGoogle(role: _selectedRole);
    if (!mounted) return;
    if (auth.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage!),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (auth.isAuthenticated) {
      context.go(
        auth.isNewUser ? AppRouter.profileSetup : _destination(auth.user?.role),
      );
    }
  }

  String _destination(String? role) => switch (role) {
    'rider' => AppRouter.riderHome,
    'admin' => AppRouter.adminDashboard,
    _ => AppRouter.home,
  };

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(26, 30, 26, 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'P',
                            style: GoogleFonts.poppins(
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Welcome to PicknShip',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Shop locally and enjoy fast delivery across Cairo.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Continue as',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _role(
                              'Customer',
                              'customer',
                              Icons.person_outline_rounded,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _role(
                              'Delivery Partner',
                              'rider',
                              Icons.delivery_dining_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Mobile number',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              widthFactor: 1,
                              child: Text(
                                '+20',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          hintText: '010 1234 5678',
                          counterText: '',
                        ),
                        validator: (value) {
                          final raw = (value ?? '').replaceAll(
                            RegExp(r'\D'),
                            '',
                          );
                          final number = raw.startsWith('0')
                              ? raw.substring(1)
                              : raw;
                          if (!RegExp(r'^(10|11|12|15)\d{8}$').hasMatch(number))
                            return 'Enter a valid Egyptian mobile number';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: FilledButton(
                          onPressed: auth.isLoading ? null : _sendOtp,
                          child: auth.isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Send verification code'),
                        ),
                      ),
                      if (DemoData.isDemoMode) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              context.read<AuthProvider>().demoLogin();
                              context.go(AppRouter.home);
                            },
                            icon: const Icon(Icons.explore_outlined),
                            label: const Text('Explore as a guest'),
                          ),
                        ),
                      ],
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'OR',
                              style: TextStyle(color: AppTheme.textMuted),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: auth.isLoading ? null : _googleSignIn,
                          icon: const Icon(
                            Icons.g_mobiledata_rounded,
                            size: 26,
                          ),
                          label: const Text('Continue with Google'),
                        ),
                      ),
                      if (auth.errorMessage != null) ...[
                        const SizedBox(height: 14),
                        Text(
                          auth.errorMessage!,
                          style: const TextStyle(color: AppTheme.errorRed),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'By continuing, you agree to our Terms of Service and Privacy Policy.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _role(String title, String value, IconData icon) {
    final selected = _selectedRole == value;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => setState(() => _selectedRole = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppTheme.primaryColor : AppTheme.hairline,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: selected ? AppTheme.primaryColor : AppTheme.textMuted,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? AppTheme.primaryColor : AppTheme.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
