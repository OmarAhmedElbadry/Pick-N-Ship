/// ============================================================
/// main.dart — App Entry Point
/// ============================================================
/// Initializes Firebase (if not in demo mode), registers all
/// Providers, and launches the app.
//
/// DEMO MODE: Set DemoData.isDemoMode = true to run the app
/// without Firebase. All data comes from demo_data.dart.
/// ============================================================

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'config/app_router.dart';
import 'config/demo_data.dart';
import 'providers/auth_provider.dart';
import 'providers/shop_provider.dart';
import 'providers/product_provider.dart';
import 'firebase_options.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';

import 'providers/rider_provider.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // The app runs with bundled sample data until the owner explicitly
  // supplies their Firebase configuration at build time.
  DemoData.isDemoMode = const bool.fromEnvironment(
    'DEMO_MODE',
    defaultValue: true,
  );

  if (!DemoData.isDemoMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize local notifications
    await NotificationService().initialize();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ShopProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => RiderProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp.router(
        title: 'PicknShip Egypt',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
