# E-Commerce App

A simple Flutter e-commerce app with offline support and dark mode.

## Architecture
Uses a **Feature-First** folder structure:
- `lib/features/`: Contains UI, controllers, and models grouped by feature (e.g., login, product list).
- `lib/core/`: Database helpers and app constants.
- `lib/utils/`: Contains Images and Colors.

## State Management
- **GetX**: Used for state management, routing, and dependency injection.
- UI updates are handled via `GetBuilder` and `GetxController` for lightweight and predictable rebuilds.

## Offline Storage
- **SQLite (sqflite)**: Used as the local cache.
- **Offline-First Flow**: On launch, the app checks for network. If online, it fetches data from the API, updates SQLite (preserving local favorite states), and loads the UI from the DB. If offline, it loads directly from SQLite.

## How to Run
1. Ensure Flutter is installed (`flutter doctor`).
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to launch the app on your emulator or connected device.

## Features Added
- Dark Mode toggle (in AppBar).
- Pagination and Pull-to-refresh.
- Favorite toggling (synced locally).
