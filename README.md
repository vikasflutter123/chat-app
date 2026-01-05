# Slack Clone – Flutter & Firebase

A real-time **Slack-like messaging application** built using **Flutter** and **Firebase**, showcasing modern app architecture, clean UI, and real-time communication. This project is intended for **demo, learning, and interview showcase purposes**.

---

## 📋 Project Overview

This application replicates core Slack features such as **channel-based messaging**, **real-time updates**, and **user authentication**, using Firebase as the backend and Flutter for a cross-platform UI.

The app supports **web, Android, and iOS**, with responsive layouts and automatic light/dark theme switching.

---

## ✨ Key Features

* 🔐 **User Authentication** – Email & password signup/login
* 🏢 **Channel Management** – Create and join public channels
* 💬 **Real-time Messaging** – Instant updates via Firestore streams
* 😀 **Message Reactions** – Emoji reactions synced in real time
* 👤 **User Profiles** – Display sender name and avatar initials
* 🌓 **Theme Support** – Automatic light/dark mode
* 📱 **Responsive UI** – Mobile, tablet, and web support
* 🔄 **Pull-to-Refresh** – Refresh channel lists
* 🎨 **Modern UI** – Material Design, gradients, and animations

---

## 🛠 Tech Stack & Versions

### Core Framework

* **Flutter**: 3.32.4+
* **Dart**: 3.8.1+
* **Firebase**: Backend-as-a-Service

### Main Dependencies

```yaml
dependencies:
  firebase_core: ^2.24.3
  firebase_auth: ^4.13.0
  cloud_firestore: ^4.15.0
  flutter_riverpod: ^2.4.9
  intl: ^0.19.0
  shimmer: ^3.0.0
```

### Development Tools

* Android Studio / VS Code
* Firebase CLI
* Git (version control)

---

## 🚀 Setup Instructions (Local)

### Prerequisites

* Flutter SDK **3.32.4+** installed
* Firebase account
* Android/iOS emulator or physical device
* Chrome (for web testing)

---

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/slack-clone.git
cd slack-clone
```

---

### Step 2: Install Dependencies

```bash
flutter pub get
```

---

### Step 3: Firebase Setup

#### A. Create Firebase Project

1. Go to **Firebase Console**
2. Click **Add project**
3. Name the project (e.g. `slack-clone-demo`)
4. Disable Google Analytics (optional)

#### B. Enable Firebase Services

**Authentication**

* Enable **Email/Password** provider

**Firestore Database**

* Create database in **test mode**
* Select nearest region

---

#### C. Register Web App

1. Click **Web (</>)** icon in Firebase Console
2. Register app (e.g. `slack-clone-web`)
3. Copy Firebase configuration

Create the file below:

```dart
// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('Platform not supported');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    authDomain: 'YOUR_PROJECT.firebaseapp.com',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT.appspot.com',
    messagingSenderId: 'YOUR_SENDER_ID',
    appId: 'YOUR_APP_ID',
  );
}
```

⚠️ **Do not commit real API keys to public repositories**.

---

### Step 4: Run the Application

```bash
# Web (recommended)
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios
```

---

### Step 5: Test Credentials

```
Email: test@example.com
Password: password123
```

---

## 🔐 Firestore Security Rules (Minimum)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /channels/{channel} {
      allow read: if true;
      allow write: if request.auth != null;

      match /messages/{message} {
        allow read: if true;
        allow create: if request.auth != null;
      }
    }
  }
}
```

---

## 🏗 Architecture Overview

### State Management – Riverpod

* Compile-safe providers
* Easy testing and mocking
* Optimized rebuilds

```dart
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(...);
final channelsProvider = StreamProvider<List<Channel>>(...);
final currentChannelProvider = StateProvider<String>((ref) => '');
```

---

### Firestore Data Structure

#### Channels Collection

```dart
{
  'name': '#general',
  'description': 'General discussions',
  'isPrivate': false,
  'memberCount': 1,
  'createdAt': Timestamp,
  'lastActivity': Timestamp
}
```

#### Messages Subcollection

```dart
{
  'text': 'Hello everyone!',
  'senderId': 'user_123',
  'senderName': 'John Doe',
  'timestamp': Timestamp,
  'reactions': {
    '👍': ['user_123']
  }
}
```

---

## ⚠️ Assumptions & Limitations

### Assumptions

* Small-scale demo application
* Public channels only
* Text-only messages
* Single workspace
* Equal user permissions

### Limitations

* No offline support
* No push notifications
* No message editing/deletion
* No threads or search
* No file uploads or DMs

---

## 🚀 Future Improvements

### Performance

* Pagination & infinite scroll
* Local caching (Hive/SQLite)
* Firestore write optimization

### Features

* Direct messages
* File & image uploads
* Message threads
* Push notifications
* Typing indicators & read receipts

### Security

* Rate limiting via Cloud Functions
* Role-based permissions
* Input sanitization

### Developer Experience

* Unit & widget tests
* CI/CD with GitHub Actions
* Clean Architecture & repository pattern
* Localization & accessibility

---

## 📱 Demo Checklist

* ✅ Authentication flow
* ✅ Channel creation
* ✅ Real-time messaging
* ✅ Emoji reactions
* ✅ Theme switching
* ✅ Multi-client sync

---

## 📄 License

This project is created **for demonstration and educational purposes only**.

The code is provided *as-is*. For production use, additional security, testing, and scalability work is required.

---

## 🤝 Contributing

Suggestions and improvements are welcome:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a pull request

---

**Built with Flutter ❤️ & Firebase 🔥**
