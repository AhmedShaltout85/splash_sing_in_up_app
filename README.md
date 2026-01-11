# 🚀 Splash Sign In/Up App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

A modern, feature-rich Flutter authentication application with animated splash screen, complete sign-in/sign-up flow, and Firebase backend integration.

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Documentation](#-documentation) • [Contributing](#-contributing)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Setup](#firebase-setup)
  - [Running the App](#running-the-app)
- [Project Structure](#-project-structure)
- [Configuration](#-configuration)
- [Dependencies](#-dependencies)
- [Architecture](#-architecture)
- [API Documentation](#-api-documentation)
- [Testing](#-testing)
- [Deployment](#-deployment)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)
- [Contact](#-contact)

---

## 🎯 Overview

The **Splash Sign In/Up App** is a production-ready Flutter authentication template that provides a complete user authentication system. It features a beautiful animated splash screen, secure Firebase authentication, form validation, error handling, and a clean, modern UI that works across all platforms.

### Why Use This Project?

- ✅ **Production-Ready**: Fully functional authentication system
- ✅ **Cross-Platform**: Works on Android, iOS, Web, Windows, macOS, and Linux
- ✅ **Secure**: Firebase Authentication with best practices
- ✅ **Modern UI**: Beautiful, responsive design with animations
- ✅ **Well-Documented**: Comprehensive code documentation and examples
- ✅ **Easy to Customize**: Modular architecture for quick modifications

---

## ✨ Features

### Core Features

- 🎨 **Animated Splash Screen**
  - Native splash screen support
  - Smooth transitions to main app
  - Customizable branding and colors
  - Auto-generated for all platforms

- 🔐 **User Authentication**
  - Email/Password registration
  - Secure login system
  - Password strength validation
  - Email verification support
  - Remember me functionality
  - Password reset/recovery

- 🎯 **User Experience**
  - Form validation with real-time feedback
  - Loading indicators during async operations
  - Error handling with user-friendly messages
  - Responsive design for all screen sizes
  - Smooth page transitions and animations

- 🔥 **Firebase Integration**
  - Firebase Authentication
  - Cloud Firestore ready
  - Firebase Analytics support
  - Crash reporting capabilities
  - Remote Config ready

### Advanced Features

- 📱 **Platform Support**
  - Android (API 21+)
  - iOS (iOS 12+)
  - Web (Chrome, Firefox, Safari, Edge)
  - Windows Desktop
  - macOS Desktop
  - Linux Desktop

- 🎨 **Customization**
  - Theme customization
  - Multi-language support ready
  - Custom fonts and icons
  - Branded splash screens

---

## 📱 Screenshots

> 📸 Add your app screenshots here

```
# Suggested screenshots to include:
- Splash screen animation
- Sign-in page
- Sign-up page
- Password reset page
- Loading states
- Error states
- Different platform views
```

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your development machine:

#### Required Software

| Software | Version | Download Link |
|----------|---------|---------------|
| Flutter SDK | ≥ 3.0.0 | [flutter.dev](https://docs.flutter.dev/get-started/install) |
| Dart SDK | ≥ 3.0.0 | Included with Flutter |
| Git | Latest | [git-scm.com](https://git-scm.com/) |
| Firebase CLI | Latest | [firebase.google.com/docs/cli](https://firebase.google.com/docs/cli) |

#### Platform-Specific Requirements

**For Android Development:**

- Android Studio or IntelliJ IDEA
- Android SDK (API 21 or higher)
- Java Development Kit (JDK 11+)

**For iOS Development:**

- macOS computer
- Xcode 13.0 or higher
- CocoaPods

**For Web Development:**

- Chrome browser (for debugging)

**For Desktop Development:**

- Windows: Visual Studio 2019 or higher with C++ desktop development
- macOS: Xcode
- Linux: Clang, CMake, GTK development libraries

#### Check Your Installation

```bash
flutter doctor -v
```

This command checks your environment and displays a report of the status of your Flutter installation.

---

### Installation

Follow these steps to set up the project locally:

#### 1. Clone the Repository

```bash
# Using HTTPS
git clone https://github.com/AhmedShaltout85/splash_sing_in_up_app.git

# Or using SSH
git clone git@github.com:AhmedShaltout85/splash_sing_in_up_app.git

# Navigate to project directory
cd splash_sing_in_up_app
```

#### 2. Install Flutter Dependencies

```bash
flutter pub get
```

This command downloads all the packages listed in `pubspec.yaml`.

#### 3. Verify Installation

```bash
flutter pub deps
```

Check that all dependencies are resolved correctly.

---

### Firebase Setup

#### Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** or **"Create a project"**
3. Enter your project name (e.g., "SplashAuthApp")
4. Enable Google Analytics (optional but recommended)
5. Click **"Create project"**

#### Step 2: Register Your Apps

##### For Android

1. In Firebase Console, click **"Add app"** → **Android**
2. Enter your Android package name:
   - Find it in `android/app/build.gradle` → `applicationId`
   - Example: `com.yourcompany.splash_sing_in_up_app`
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

##### For iOS

1. In Firebase Console, click **"Add app"** → **iOS**
2. Enter your iOS bundle ID:
   - Find it in `ios/Runner.xcodeproj/project.pbxproj` → `PRODUCT_BUNDLE_IDENTIFIER`
   - Example: `com.yourcompany.splashSingInUpApp`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

##### For Web

1. In Firebase Console, click **"Add app"** → **Web**
2. Register your web app
3. Copy the Firebase configuration
4. Update `web/index.html` with your Firebase config:

```html
<script>
  var firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID"
  };
</script>
```

#### Step 3: Enable Authentication Methods

1. In Firebase Console, go to **Authentication** → **Sign-in method**
2. Enable **Email/Password** authentication
3. (Optional) Enable other providers:
   - Google
   - Facebook
   - Apple
   - Anonymous

#### Step 4: Configure Firebase CLI

```bash
# Install Firebase CLI globally
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in your project
firebase init

# Select the following features:
# - Firestore (if using database)
# - Functions (if using cloud functions)
# - Hosting (if deploying web)
```

---

### Running the App

#### Run on Different Platforms

##### Android

```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run in release mode
flutter run --release
```

##### iOS

```bash
# Open iOS simulator
open -a Simulator

# Run on simulator
flutter run

# Run on physical device (ensure device is connected and trusted)
flutter run -d <device-id>
```

##### Web

```bash
# Run on Chrome
flutter run -d chrome

# Run on specific port
flutter run -d chrome --web-port=8080

# Build for web deployment
flutter build web
```

##### Desktop

```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

#### Hot Reload

While the app is running, press:

- `r` - Hot reload
- `R` - Hot restart
- `q` - Quit

---

## 📂 Project Structure

```
splash_sing_in_up_app/
│
├── android/                    # Android-specific files
│   ├── app/
│   │   ├── src/
│   │   ├── build.gradle
│   │   └── google-services.json
│   └── build.gradle
│
├── ios/                        # iOS-specific files
│   ├── Runner/
│   │   ├── Info.plist
│   │   └── GoogleService-Info.plist
│   └── Runner.xcodeproj/
│
├── web/                        # Web-specific files
│   ├── index.html
│   ├── manifest.json
│   └── icons/
│
├── windows/                    # Windows-specific files
├── macos/                      # macOS-specific files
├── linux/                      # Linux-specific files
│
├── lib/                        # Main application code
│   ├── main.dart              # App entry point
│   │
│   ├── screens/               # UI screens
│   │   ├── splash_screen.dart
│   │   ├── sign_in_screen.dart
│   │   ├── sign_up_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   └── home_screen.dart
│   │
│   ├── widgets/               # Reusable widgets
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── loading_indicator.dart
│   │   └── error_dialog.dart
│   │
│   ├── services/              # Business logic & services
│   │   ├── auth_service.dart
│   │   ├── firebase_service.dart
│   │   └── validation_service.dart
│   │
│   ├── models/                # Data models
│   │   ├── user_model.dart
│   │   └── auth_result_model.dart
│   │
│   ├── providers/             # State management (if using Provider)
│   │   └── auth_provider.dart
│   │
│   ├── utils/                 # Utility functions
│   │   ├── constants.dart
│   │   ├── helpers.dart
│   │   └── validators.dart
│   │
│   ├── config/                # Configuration files
│   │   ├── theme.dart
│   │   ├── routes.dart
│   │   └── app_config.dart
│   │
│   └── l10n/                  # Localization files
│       ├── app_en.arb
│       └── app_ar.arb
│
├── assets/                     # Static assets
│   ├── images/
│   │   ├── logo.png
│   │   └── splash_background.png
│   ├── fonts/
│   └── animations/
│
├── test/                       # Unit tests
│   ├── widget_test.dart
│   └── auth_service_test.dart
│
├── integration_test/           # Integration tests
│
├── .gitignore                  # Git ignore rules
├── pubspec.yaml               # Dependencies & assets
├── pubspec.lock               # Locked dependency versions
├── analysis_options.yaml      # Dart analyzer options
├── flutter_native_splash.yaml # Splash screen configuration
├── firebase.json              # Firebase configuration
├── README.md                  # This file
└── LICENSE                    # License information
```

---

## ⚙️ Configuration

### Splash Screen Configuration

The splash screen is configured in `flutter_native_splash.yaml`:

```yaml
flutter_native_splash:
  # Background color (hex or named color)
  color: "#ffffff"
  
  # Splash image (center of screen)
  image: assets/images/splash_logo.png
  
  # Branding image (bottom of screen)
  branding: assets/images/branding.png
  
  # Image fill mode
  fill: true
  
  # Platform-specific settings
  android: true
  ios: true
  web: true
  
  # Android 12+ specific
  android_12:
    image: assets/images/splash_logo_android12.png
    color: "#ffffff"
    icon_background_color: "#ffffff"
  
  # Full screen mode
  fullscreen: true
  
  # Info.plist settings
  info_plist_files:
    - 'ios/Runner/Info.plist'
```

#### Regenerate Splash Screen

After modifying the configuration:

```bash
flutter pub run flutter_native_splash:create
```

To remove the splash screen:

```bash
flutter pub run flutter_native_splash:remove
```

### Theme Configuration

Customize your app's theme in `lib/config/theme.dart`:

```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF6C63FF),
    scaffoldBackgroundColor: Colors.white,
    // ... more theme properties
  );
  
  static ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xFF6C63FF),
    scaffoldBackgroundColor: Color(0xFF121212),
    // ... more theme properties
  );
}
```

### App Constants

Define app-wide constants in `lib/utils/constants.dart`:

```dart
class AppConstants {
  // App Information
  static const String appName = 'Splash Auth App';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'https://api.yourapp.com';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String isFirstTimeKey = 'is_first_time';
  
  // Validation
  static const int minPasswordLength = 8;
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
}
```

---

## 📦 Dependencies

### Main Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Firebase
  firebase_core: ^2.24.2           # Firebase core functionality
  firebase_auth: ^4.15.3           # Authentication
  cloud_firestore: ^4.13.6         # Cloud database
  firebase_analytics: ^10.7.4      # Analytics
  
  # State Management
  provider: ^6.1.1                 # State management (or use Riverpod/Bloc)
  
  # UI & Animations
  flutter_native_splash: ^2.3.8    # Native splash screens
  animations: ^2.0.11              # Pre-built animations
  lottie: ^3.0.0                   # Lottie animations
  
  # Form & Validation
  flutter_form_builder: ^9.1.1     # Form building
  form_builder_validators: ^9.1.0  # Form validation
  
  # Utilities
  shared_preferences: ^2.2.2       # Local storage
  intl: ^0.19.0                    # Internationalization
  connectivity_plus: ^5.0.2        # Network connectivity
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1            # Linting rules
  mockito: ^5.4.4                  # Mocking for tests
```

### Installing a New Package

```bash
# Add to pubspec.yaml, then run:
flutter pub get

# Or add directly via command:
flutter pub add package_name
```

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with separation of concerns:

### Layers

1. **Presentation Layer** (`screens/` & `widgets/`)
   - UI components
   - User interactions
   - State management

2. **Business Logic Layer** (`services/` & `providers/`)
   - Application logic
   - State management
   - Data transformation

3. **Data Layer** (`models/`)
   - Data models
   - API responses
   - Local storage

### Design Patterns Used

- **Singleton Pattern**: For service instances
- **Factory Pattern**: For model creation
- **Observer Pattern**: For state management (Provider)
- **Repository Pattern**: For data access abstraction

### State Management

This project uses **Provider** for state management. Example:

```dart
// auth_provider.dart
class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  
  User? get user => _user;
  bool get isLoading => _isLoading;
  
  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _user = await AuthService.signIn(email, password);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

---

## 📖 API Documentation

### Authentication Service

#### Sign Up

```dart
Future<User?> signUp({
  required String email,
  required String password,
  required String displayName,
}) async {
  try {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    await userCredential.user?.updateDisplayName(displayName);
    await userCredential.user?.sendEmailVerification();
    
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    throw _handleAuthException(e);
  }
}
```

#### Sign In

```dart
Future<User?> signIn({
  required String email,
  required String password,
}) async {
  try {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    throw _handleAuthException(e);
  }
}
```

#### Sign Out

```dart
Future<void> signOut() async {
  await _auth.signOut();
}
```

#### Reset Password

```dart
Future<void> resetPassword(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    throw _handleAuthException(e);
  }
}
```

### Error Handling

```dart
String _handleAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'No user found with this email.';
    case 'wrong-password':
      return 'Wrong password provided.';
    case 'email-already-in-use':
      return 'An account already exists with this email.';
    case 'weak-password':
      return 'Password should be at least 8 characters.';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    default:
      return 'An error occurred. Please try again.';
  }
}
```

---

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/auth_service_test.dart

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Unit Test Example

```dart
// test/auth_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('AuthService Tests', () {
    test('Sign in with valid credentials should return user', () async {
      // Arrange
      final authService = AuthService();
      
      // Act
      final user = await authService.signIn(
        email: 'test@example.com',
        password: 'password123',
      );
      
      // Assert
      expect(user, isNotNull);
      expect(user?.email, equals('test@example.com'));
    });
  });
}
```

### Widget Test Example

```dart
// test/sign_in_screen_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Sign in button should be disabled when fields are empty', 
    (WidgetTester tester) async {
    // Build widget
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));
    
    // Find button
    final button = find.byType(ElevatedButton);
    
    // Verify button is disabled
    expect(tester.widget<ElevatedButton>(button).enabled, isFalse);
  });
}
```

---

## 🚢 Deployment

### Android Deployment

#### 1. Create Keystore

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

#### 2. Configure Signing

Create `android/key.properties`:

```properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=<path-to-keystore>
```

#### 3. Build Release APK

```bash
flutter build apk --release
```

#### 4. Build App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

### iOS Deployment

#### 1. Configure Xcode

1. Open `ios/Runner.xcworkspace`
2. Select Runner → Signing & Capabilities
3. Select your team
4. Configure bundle identifier

#### 2. Build IPA

```bash
flutter build ipa --release
```

#### 3. Upload to App Store

Use Xcode or Transporter app to upload the IPA.

### Web Deployment

#### 1. Build Web App

```bash
flutter build web --release
```

#### 2. Deploy to Firebase Hosting

```bash
firebase deploy --only hosting
```

#### 3. Deploy to Other Platforms

The built files are in `build/web/` directory. Upload to:

- GitHub Pages
- Netlify
- Vercel
- AWS S3
- Any web server

---

## 🔧 Troubleshooting

### Common Issues

#### Issue: Firebase initialization failed

**Solution:**

```bash
# Verify configuration files exist
ls -la android/app/google-services.json
ls -la ios/Runner/GoogleService-Info.plist

# Reinstall dependencies
flutter clean
flutter pub get
```

#### Issue: Splash screen not showing

**Solution:**

```bash
# Regenerate splash screen
flutter pub run flutter_native_splash:create

# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### Issue: Build failed on iOS

**Solution:**

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter run
```

#### Issue: Hot reload not working

**Solution:**

- Press `R` for hot restart instead of `r`
- Stop and restart the app
- Check for syntax errors

### Getting Help

If you encounter issues:

1. Check the [issues page](https://github.com/AhmedShaltout85/splash_sing_in_up_app/issues)
2. Search [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
3. Read [Flutter documentation](https://docs.flutter.dev/)
4. Join [Flutter community](https://flutter.dev/community)

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

### How to Contribute

1. **Fork the repository**

   ```bash
   # Click "Fork" button on GitHub
   ```

2. **Clone your fork**

   ```bash
   git clone https://github.com/YOUR_USERNAME/splash_sing_in_up_app.git
   cd splash_sing_in_up_app
   ```

3. **Create a feature branch**

   ```bash
   git checkout -b feature/amazing-feature
   ```

4. **Make your changes**
   - Write clean, documented code
   - Follow existing code style
   - Add tests for new features

5. **Commit your changes**

   ```bash
   git add .
   git commit -m "Add amazing feature"
   ```

6. **Push to your fork**

   ```bash
   git push origin feature/amazing-feature
   ```

7. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Describe your changes

### Code Style Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write tests for new features

### Commit Message Format

```
type(scope): subject

body

footer
```

**Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build process or auxiliary tool changes

**Example:**

```
feat(auth): add Google sign-in

- Add Google sign-in button to login screen
- Integrate Firebase Google authentication
- Add error handling for Google auth

Closes #123
```

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Ahmed Shaltout

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👤 Author

**Ahmed Shaltout**

- GitHub: [@AhmedShaltout85](https://github.com/AhmedShaltout85)
- Email: [Contact via GitHub](https://github.com/AhmedShaltout85)

---

## 🙏 Acknowledgments

Special thanks to:

- **Flutter Team** - For the amazing framework
- **Firebase Team** - For backend services
- **Open Source Community** - For inspiration and support
- **Contributors** - For making this project better

### Resources Used

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Pub.dev Packages](https://pub.dev/)
- [Material Design Guidelines](https://material.io/design)

---

## 📞 Support

### Get Help

- 📧 **Email**: Create an issue on GitHub for fastest response
- 💬 **Discussions**: Use [GitHub Discussions](https://github.com/AhmedShaltout85/splash_sing_in_up_app/discussions)
- 🐛 **Bug Reports**: [Open an issue](https://github.com/AhmedShaltout85/splash_sing_in_up_app/issues/new)
- ⭐ **Feature Requests**: [Request a feature](https://github.com/AhmedShaltout85/splash_sing_in_up_app/issues/new)

### Stay Updated

- ⭐ Star this repository to show support
- 👁️ Watch for updates and releases
- 🔔 Follow for future projects

---

## 🔮 Roadmap

### Version 1.1.0 (Planned)

- [ ] Social media authentication
  - [ ] Google Sign-In
  - [ ] Facebook Login
  - [ ] Apple Sign-In
- [ ] Biometric authentication
  - [ ] Fingerprint
  - [ ] Face ID
- [ ] Profile management
  - [ ] Edit profile
  - [ ] Upload profile picture
  - [ ] Change password

### Version 1.2.0 (Planned)

- [ ] Dark mode support
- [ ] Multi-language support (i18n)
  - [ ] English
  - [ ] Arabic
  - [ ] Spanish
- [ ] Offline mode
- [ ] Push notifications

### Version 2.0.0 (Future)

- [ ] Advanced user roles
- [ ] Two-factor authentication (2FA)
- [ ] Email templates customization
- [ ] Analytics dashboard
- [ ] Admin panel

---

## 📊 Stats

![GitHub stars](https://img.shields.io/github/stars/AhmedShaltout85/splash_sing_in_up_app?style=social)
![GitHub forks](https://img.shields.io/github/forks/AhmedShaltout85/splash_sing_in_up_app?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/AhmedShaltout85/splash_sing_in_up_app?style=social)
![GitHub issues](https://img.shields.io/github/issues/AhmedShaltout85/splash_sing_in_up_app)
![GitHub pull requests](https://img.shields.io/github/issues-pr/AhmedShaltout85/splash_sing_in_up_app)
![GitHub last commit](https://img.shields.io/github/last-commit/AhmedShaltout85/splash_sing_in_up_app)
![GitHub repo size](https://img.shields.io/github/repo-size/AhmedShaltout85/splash_sing_in_up_app)

---

<div align="center">

### ⭐ If you found this project helpful, please give it a star

**Made with ❤️ using Flutter**

[⬆ Back to Top](#-splash-sign-inup-app)

</div>
