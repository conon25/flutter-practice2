# 📸 Instagram Clone using Flutter & Firebase

A clean and modern Instagram clone built with **Flutter** and **Firebase**, featuring real-time feed, image uploads, and secure user authentication.

![Banner](https://github.com/user-attachments/assets/b96e7379-2b2f-4ea1-8db7-881d17e986ea)

---

## 🚀 Features

- 🔐 Firebase Authentication (Email & Password)
- 🏠 Feed screen with real-time Firestore updates
- 🔍 Search users by username
- 🖼️ Upload and display posts with captions
- 👤 Profile screen with post grid and user info

---

## 🛠️ Getting Started

### ✅ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)  
- [Firebase Console](https://console.firebase.google.com/) project setup

### 🔧 Setup Instructions

1. **Clone the repository**
   ```sh
   git clone https://github.com/ahsxndev/instagram-clone
   cd instagram-clone

2. **Install dependencies**

   ```sh
   flutter pub get
   ```

3. **Firebase configuration**

   * Create a new Firebase project.
   * Register Android/iOS/Web apps.
   * Add the config files:

     * `google-services.json` → `android/app/`
     * `GoogleService-Info.plist` → `ios/Runner/`
   * Replace placeholders in `lib/firebase_options.dart`:

     ```dart
     const FirebaseOptions(
       apiKey: 'YOUR_API_KEY',
       appId: 'YOUR_APP_ID',
       messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
       projectId: 'YOUR_PROJECT_ID',
       ...
     );
     ```

4. **Run the app**

   ```sh
   flutter run
   ```

---

## 📁 Project Structure

```
lib/
├── main.dart
├── firebase_options.dart
├── provider/
├── resources/
├── route handling/
├── screens/
├── utils/
assets/
android/
ios/
web/
...
```

---

## 📄 License

This project is open-source and intended for **educational use only**.
Feel free to fork, learn, and build upon it — just don’t forget to give credit. 🙌

---

### 💡 Final Notes

> Built for learning. Designed with Flutter. Powered by Firebase.
