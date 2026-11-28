# Pick-N-Ship

Pick-N-Ship is a Flutter app for on-demand courier delivery. A customer picks a pickup point and a drop-off point, enters sender, recipient and package details, gets a price estimate, and confirms the request. A company driver then collects the package and delivers it, with live tracking.

## Status

Work in progress. The project started as a multi-shop delivery app (shops, products, cart, riders, admin) and is being reshaped step by step into a courier app. Today:

- Customer login with phone and OTP screens, profile setup.
- Shop browsing, cart, checkout, order history and order tracking (the older shop flow, still present).
- A rider home screen and an admin dashboard.
- Demo mode with bundled sample data, so the app runs without a backend.

Planned courier work is tracked in `docs/development_log.md` as it lands.

## Stack

- Flutter and Dart
- Provider for state management
- go_router for navigation
- Firebase Auth, Cloud Firestore and Firebase Messaging
- flutter_map (OpenStreetMap) and geolocator for maps and location

## Project layout

```
lib/
  config/     router, theme, demo data
  models/     data models (order, product, shop, user, cart item)
  providers/  Provider state classes
  screens/    auth, customer, rider, admin screens
  services/   Firebase and device services
  utils/      helpers
  widgets/    shared widgets
```

## Running the app

Demo mode is on by default. It uses sample data only and talks to no backend.

```
flutter pub get
flutter run
```

To run against Firebase, add your own Firebase configuration (`lib/firebase_options.dart`, generated with FlutterFire) and turn demo mode off:

```
flutter run --dart-define=DEMO_MODE=false
```

## Roadmap

1. Courier delivery model and repository layer.
2. Booking flow: pickup, drop-off, contacts, package, speed, price, confirm.
3. Order tracking and delivery confirmation with a photo and a recipient code.
4. Driver screens: online status, requests, active delivery, earnings.
5. Arabic and English with right-to-left layout.
6. Tests and docs for each step.
