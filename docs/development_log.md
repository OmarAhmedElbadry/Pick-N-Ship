# Development log

One entry per change. Newest first.

## 2026-11-28

- Rewrote the README: what the app is, current status, stack, layout, how to run in demo mode and against Firebase, roadmap.
- Started this log.

## Where things stand

- The codebase began as a multi-shop delivery app. It is being reshaped into a courier app (pickup, drop-off, package, price, driver, tracking).
- Stack stays as is: Flutter, Provider, go_router, Firebase, flutter_map.
- Demo mode (`DEMO_MODE`, default true) uses bundled sample data. Anything that only works in demo mode is mock data and must stay labelled that way.

## Next

- Replace the default counter test with a real smoke test.
- Clean up pubspec (pin `pinput`, check the SDK constraint).
- Add the courier delivery model and a repository interface.
