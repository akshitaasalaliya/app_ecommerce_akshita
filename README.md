# Simple E-Commerce Product Listing App

A Flutter e-commerce product listing application built as part of a technical assignment. The app focuses on clean architecture, reusable components, smooth user experience, and practical offline support.

### Features

* Dummy login authentication
* Product listing with pagination
* Product search
* Product details
* Wishlist/Favorites
* Offline product and wishlist caching
* Pull-to-refresh
* Dark mode
* Loading, empty, and error states
* API timeout and no-internet handling
* Retry mechanism
* Responsive UI

### Tech Stack

* Flutter & Dart
* GetX for state management
* REST API
* DummyJSON Products API
* SQLite for local/offline storage
* Repository Pattern
* Feature-based architecture

### Architecture

The project follows a feature-based architecture with a repository layer to keep UI, business logic, API handling, and local storage separated.

The structure is designed to make the application easier to maintain, test, and scale as new features are added.

### Performance

* Pagination to avoid loading all products at once
* Efficient state updates to reduce unnecessary rebuilds
* Reusable widgets
* Proper loading states
* Smooth product list scrolling
* Local caching for better offline experience

### Getting Started

1. Clone the repository.
2. Run `flutter pub get`.
3. Connect an Android/iOS device or start an emulator.
4. Run `flutter run`.

No API key is required for the DummyJSON API.

### Assignment

This project was developed within the given assignment timeline and focuses on demonstrating practical Flutter development skills, clean code, architecture, state management, API integration, offline storage, and handling of real-world edge cases.
