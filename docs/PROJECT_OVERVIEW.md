# 📱 E-Commerce App — Project Overview

Welcome to the **E-Commerce App** — a Flutter-based mobile application built to browse, search, and explore products fetched from a real API, with full offline support baked right in.

This document gives you a bird's-eye view of what the app does, how it's structured, and the key decisions made during development.

---

## What is this app?

This is a clean, feature-focused e-commerce mobile app built with Flutter. It talks to the [DummyJSON](https://dummyjson.com) products API to load real product data, stores it locally in SQLite so the app still works without internet, and lets users search, browse, and favorite products — all with a smooth, reactive UI.

Think of it as a solid foundation you can build a full shopping experience on top of.

---

## What can the app do?

Here's a quick rundown of what's working:

- 🚀 **Splash Screen** — Shows your app logo and a loading spinner while the app initializes, then automatically takes the user to login after 5 seconds.
- 🔐 **Login Screen** — A clean login form with email validation, a password visibility toggle, and form state management.
- 📦 **Product List** — Loads products from the API with pagination (10 at a time), lets you search by name or category, mark favorites, and pull to refresh. If you're offline, it gracefully falls back to locally cached data.
- 🔍 **Product Detail** — A full detail view for any product, showing its image, price, description, category, and stock — plus a favorite toggle right in the app bar.

---

## Tech Stack

| What | Tool / Package |
|------|---------------|
| **Framework** | Flutter (SDK `^3.12.2`) |
| **Language** | Dart |
| **State Management** | GetX (`get: ^4.7.3`) |
| **HTTP Client** | Dio (`dio: ^5.9.2`) |
| **Local Database** | SQLite via Sqflite (`sqflite: ^2.4.3`) |
| **Networking (fallback)** | `http: ^1.6.0` |
| **Icons** | Cupertino Icons + Material Icons |

---

## Project Structure

Here's how the codebase is organized inside `lib/`:

```
lib/
├── main.dart                        # App entry point
│
├── features/                        # All app screens, broken down by feature
│   ├── splash/
│   │   ├── splash_screen.dart
│   │   └── splash_controller.dart
│   ├── login/
│   │   ├── login_screen.dart
│   │   └── login_controller.dart
│   ├── product_list/
│   │   ├── productlist_screen.dart
│   │   ├── productlist_controller.dart
│   │   └── productlist_model.dart
│   └── product_detail/
│       ├── productdetail_screen.dart
│       └── productdetail_controller.dart
│
├── core/                            # Shared foundation layer
│   ├── constants/
│   │   └── RepositoryConstants.dart
│   └── database/
│       └── database_helper.dart
│
├── common/                          # Reusable UI widgets and helpers
│   ├── common_buttonstyle.dart
│   ├── common_textfieldstyle.dart
│   └── common_functions.dart
│
└── utils/                           # App-wide constants (colors, images)
    ├── colors.dart
    └── images.dart
```

---

## Architecture Pattern

The app follows a **feature-first architecture** using **GetX** for state management and routing.

Each feature lives in its own folder with:
- A **Screen** — the UI, what the user sees
- A **Controller** — the logic, what happens when things are tapped

This makes it really easy to find things and extend the app without touching unrelated parts.

---

## Data Flow

Here's how data moves through the app:

```
API (dummyjson.com)
        ↓
   Dio HTTP Client
        ↓
  ProductListController
        ↓  (saves to local DB)
   DatabaseHelper (SQLite)
        ↓  (always reads from local DB)
   ProductListController
        ↓
  ProductListScreen (UI)
```

The app always fetches fresh data from the API **and** caches it to SQLite. When displaying, it reads from the local database — so even if the internet goes away mid-session, things keep working.

---

## App Flow (Screen Navigation)

```
SplashScreen  (5 sec timer)
      ↓
 LoginScreen  (form validation)
      ↓
 ProductListScreen  (browse, search, favorite)
      ↓
 ProductDetailScreen  (view full details)
```

Navigation is handled by GetX using `Get.off()` and `Get.offAll()` so the back stack stays clean.

---

## Theme Support

The app supports both **light and dark mode** out of the box:
- Follows the system theme by default
- Users can manually switch themes from the product list screen using the sun/moon icon in the app bar
- `AppColors` dynamically returns the right color based on the current brightness

---

## API Details

| Detail | Value |
|--------|-------|
| **Base URL** | `https://dummyjson.com` |
| **Products Endpoint** | `/products?limit=10&skip=0` |
| **Pagination** | `limit` + `skip` query params |
| **Auth** | None (public API) |
| **Timeouts** | Connect: 15s / Receive: 15s |

---

## Offline Support

This is one of the more thoughtful parts of the app. Here's exactly what happens:

1. On launch, the app checks internet connectivity by pinging Google.
2. If online → fetches from API → saves to SQLite → reads from SQLite to display.
3. If offline → skips the API call → reads whatever's already in SQLite.
4. If offline AND SQLite is empty → shows a clear error message with a Retry button.

The favorite state is always preserved in SQLite, even when data is refreshed from the API.

---

## Assets

| Asset | Path |
|-------|------|
| App / E-Commerce Logo | `assets/images/ic_ecomerce.png` |

---

## Version Info

| Field | Value |
|-------|-------|
| App Name | `app_ecommerce_akshita` |
| Version | `1.0.0+1` |
| Dart SDK | `^3.12.2` |
| Platform | Android, iOS (+ Web, Desktop configured) |
