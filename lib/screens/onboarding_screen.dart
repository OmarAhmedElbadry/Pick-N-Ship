import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_router.dart';
import '../config/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;
  final _slides = const [
    (
      HugeIcons.strokeRoundedStore01,
      'Everything you need, nearby',
      'Discover local shops and everyday essentials around you.',
    ),
    (
      HugeIcons.strokeRoundedShoppingBasket01,
      'Order with ease',
      'Add products to your cart and follow your order in one place.',
    ),
    (
      HugeIcons.strokeRoundedLocation01,
      'Delivered to your door',
      'Enjoy a simple, reliable delivery experience across Cairo.',
    ),
  ];

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    if (mounted) context.go(AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 16, 26, 22),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _finish,
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _slides.length,
                  onPageChanged: (value) => setState(() => _index = value),
                  itemBuilder: (_, index) {
                    final item = _slides[index];
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: Column(
                        key: ValueKey(index),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F1F1),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: Center(
                              child: HugeIcon(
                                icon: item.$1,
                                size: 104,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 46),
                          Text(
                            item.$2,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            item.$3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppTheme.textMuted,
                                  height: 1.6,
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _index == i ? 24 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _index == i
                          ? AppTheme.primaryColor
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    if (_index == _slides.length - 1) {
                      _finish();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 380),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  },
                  child: Text(
                    _index == _slides.length - 1
                        ? 'Get started'
                        : 'Continue  →',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
