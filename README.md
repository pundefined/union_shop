# Union Shop

A Flutter e-commerce application recreating the University of Portsmouth Student Union shop ([shop.upsu.net](https://shop.upsu.net)). This project was developed as coursework for the **Programming Applications and Programming Languages (M30235)** module.

## 🛍️ Live Demo

**[View Live Application](https://union-shop-2308168.web.app)** *(Firebase Hosted)*

## ✨ Features

### Core Shopping Experience
- **Homepage** with featured products carousel and promotional sections
- **Collections** browsing with responsive grid layout
- **Product Pages** with size/color selection, quantity controls, and detailed information
- **Shopping Cart** with full management (add, remove, update quantities)
- **Checkout Flow** with order summary and confirmation

### Navigation & Search
- **Responsive Navigation** — adaptive navbar for mobile and desktop views
- **Deep Linking** — all pages accessible via URL routing
- **Search Functionality** — search products across the store
- **App Shell Pattern** — consistent layout with navbar and footer

### User Features
- **Firebase Authentication** — user login/signup with email and Google sign-in
- **Cart Persistence** — shopping cart maintained across sessions
- **Print Shack** — custom text personalization service with dynamic form

### Technical Features
- **Responsive Design** — works on mobile, tablet, and desktop
- **State Management** — Provider pattern for cart and authentication
- **Clean Architecture** — separated models, screens, widgets, and services

## 📸 Screenshots

| Home | Collections | Product |
|------|-------------|---------|
| Homepage with carousel | Browse product collections | Product details with options |

| Cart | Search | Login |
|------|--------|-------|
| Shopping cart management | Search results | Authentication |

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (≥2.17.0, <4.0.0)
- **Git**
- **Chrome browser** (for web development)
- **VS Code** (recommended) or Android Studio

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/pundefined/union_shop.git
   cd union_shop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify setup**
   ```bash
   flutter doctor
   ```

### Running the Application

This app is optimized for **web** and should be viewed in **mobile view** using Chrome DevTools.

```bash
flutter run -d chrome
```

**To enable mobile view:**
1. Open Chrome DevTools (`F12` or right-click → Inspect)
2. Click the "Toggle device toolbar" button
3. Select a mobile device preset (e.g., iPhone 12 Pro, Pixel 5)

## 📁 Project Structure

```
union_shop/
├── lib/
│   ├── main.dart              # App entry point and configuration
│   ├── router.dart            # GoRouter navigation setup
│   ├── firebase_options.dart  # Firebase configuration
│   ├── models/                # Data models
│   │   ├── auth_provider.dart # Authentication state
│   │   ├── cart.dart          # Cart state management
│   │   ├── collection.dart    # Collection model
│   │   ├── product.dart       # Product model
│   │   └── carousel_slide.dart
│   ├── screens/               # App screens/pages
│   │   ├── home.dart
│   │   ├── about_page.dart
│   │   ├── cart_page.dart
│   │   ├── checkout_page.dart
│   │   ├── collection_page.dart
│   │   ├── collections_page.dart
│   │   ├── login_signup_screen.dart
│   │   ├── product_page.dart
│   │   ├── search_page.dart
│   │   └── print_shack_*.dart
│   ├── widgets/               # Reusable UI components
│   │   ├── app_shell.dart     # Main layout wrapper
│   │   ├── app_navbar.dart    # Navigation bar
│   │   ├── app_footer.dart    # Footer component
│   │   ├── carousel.dart      # Image carousel
│   │   ├── product_card.dart  # Product display card
│   │   └── ...
│   ├── services/              # External services
│   │   └── auth_service.dart  # Firebase auth service
│   ├── styles/                # Theme and styling
│   └── utils/                 # Utility functions
├── test/                      # Widget and unit tests
│   ├── screens/
│   ├── widgets/
│   ├── models/
│   └── helpers/
├── assets/
│   └── images/                # App images
└── pubspec.yaml               # Dependencies
```

## 🛠️ Technologies Used

### Framework & Language
- **Flutter** — Cross-platform UI framework
- **Dart** — Programming language

### Key Packages
| Package | Purpose |
|---------|---------|
| `provider` | State management |
| `go_router` | Declarative routing & deep linking |
| `firebase_core` | Firebase initialization |
| `firebase_auth` | User authentication |

### External Services
- **Firebase Authentication** — User sign-in (email/password, Google)
- **Firebase Hosting** — Live web deployment

### Development Tools
- **VS Code** with Flutter extension
- **Chrome DevTools** for responsive testing
- **Git** for version control

## 🐛 Known Issues & Limitations

- **Web-focused** — Primary testing done on Chrome; native mobile may have minor UI differences
- **Sample Data** — Products and collections use placeholder data, not connected to a live inventory
- **Payment** — Checkout flow is simulated; no real payment processing
