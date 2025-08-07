** 초기 셋팅 방법 **
- 플러터SDK 버전 3.10.5
- 자바JDK 버전 17 셋팅
- 자바경로 환경변수 추가 - JAVA_HOME

** firebase auth 연결 완료 **
테스트 계정 : test@gmail.com / testtest12#


<div align="center">

# 📸 Instagram Clone

### A modern Instagram clone built with Flutter & Firebase

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

[![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](#)
[![GitHub Forks](https://img.shields.io/github/forks/ahsxndev/instagram-clone.svg?style=social&label=Fork&maxAge=2592000)](https://github.com/ahsxndev/instagram-clone/fork)
[![GitHub Issues](https://img.shields.io/github/issues/ahsxndev/instagram-clone.svg?style=flat&label=Issues&maxAge=2592000)](https://github.com/ahsxndev/instagram-clone/issues)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat&label=Contributions&colorA=red&colorB=black)](#)

Clean, modern Instagram clone featuring real-time feed, image uploads, and secure authentication.

![Banner](https://github.com/user-attachments/assets/b96e7379-2b2f-4ea1-8db7-881d17e986ea)

</div>

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🔐 **Authentication & Security**
- Firebase Email/Password Authentication
- Secure user registration & login
- Password reset functionality
- User session management

</td>
<td width="50%">

### 📱 **Core Functionality**
- Real-time feed with Firestore updates
- Image upload with Firebase Storage
- User search by username
- Profile management with post grid

</td>
</tr>
</table>

### 🎯 **Additional Features**
- 📷 Camera integration for photo capture
- 💬 Post captions and descriptions
- 👥 User profiles with follower/following counts
- 🔄 Pull-to-refresh functionality
- 📱 Responsive design for all screen sizes

---

## 🚀 Getting Started

### Prerequisites

```bash
Flutter SDK     >=3.0.0
Dart SDK        >=2.17.0
Firebase CLI    Latest version
Android Studio  or VS Code
```

### 🔧 Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/ahsxndev/instagram-clone.git
   cd instagram-clone
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   
   **Create Firebase Project:**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Enable Firebase Storage

   **Add Configuration Files:**
   ```bash
   # Android
   # Download google-services.json from Firebase Console
   # Place it in: android/app/google-services.json
   
   # iOS
   # Download GoogleService-Info.plist from Firebase Console
   # Place it in: ios/Runner/GoogleService-Info.plist
   ```

   **Update Firebase Options:**
   ```dart
   // lib/firebase_options.dart
   static const FirebaseOptions android = FirebaseOptions(
     apiKey: 'YOUR_ANDROID_API_KEY',
     appId: 'YOUR_ANDROID_APP_ID',
     messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
     projectId: 'YOUR_PROJECT_ID',
     storageBucket: 'YOUR_STORAGE_BUCKET',
   );
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `firebase_core` | Firebase initialization |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Real-time database |
| `firebase_storage` | Image storage |
| `image_picker` | Camera/gallery access |
| `provider` | State management |
| `cached_network_image` | Efficient image loading |

---


## 🎨 Screens & Features

### 🔐 Authentication
- **Login Screen** - Email/password authentication
- **Signup Screen** - New user registration with profile setup

### 📱 Main App
- **Feed Screen** - Instagram-like post feed with real-time updates
- **Search Screen** - Find users by username
- **Add Post** - Upload photos with captions
- **Profile Screen** - User info and post grid display

---

## 🔧 Firebase Configuration

### Firestore Database Structure
```javascript
// Users Collection
users: {
  uid: {
    username: "string",
    email: "string",
    bio: "string",
    photoUrl: "string",
    followers: ["uid1", "uid2"],
    following: ["uid3", "uid4"]
  }
}

// Posts Collection
posts: {
  postId: {
    description: "string",
    uid: "string",
    username: "string",
    postUrl: "string",
    profImage: "string",
    likes: ["uid1", "uid2"],
    datePublished: "timestamp"
  }
}
```

### Security Rules
```javascript
// Firestore Rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == resource.data.uid;
    }
  }
}
```

---

## 🚀 Building for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS (requires Xcode)
flutter build ios --release
```

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Guidelines
- Follow Flutter/Dart style conventions
- Test your changes on multiple devices
- Update documentation for new features
- Ensure Firebase security rules are properly configured

---

## 📄 License

This project is licensed under the **MIT License** and is intended for **educational purposes**.

Feel free to fork, learn, and build upon it — attribution is appreciated! 🙌

---

## 🙏 Acknowledgments

**Special Thanks:**

📚 **Flutter Team** - For the amazing cross-platform framework  
🔥 **Firebase Team** - For the powerful backend services  
🎓 **Flutter Community** - For tutorials and inspiration  
🌟 **Open Source Contributors** - For continuous improvements  

---

## 📞 Support

<div align="center">

**Found this helpful?** Give it a ⭐ on GitHub!

📧 **Email:** [ahsanzaman.dev@gmail.com](mailto:ahsanzaman.dev@gmail.com)  
🐛 **Issues:** [Report Issues](https://github.com/ahsxndev/instagram-clone/issues)  
💬 **Discussions:** [Join Discussion](https://github.com/ahsxndev/instagram-clone/discussions)  

[![GitHub followers](https://img.shields.io/github/followers/ahsxndev?style=social)](https://github.com/ahsxndev)
[![GitHub stars](https://img.shields.io/github/stars/ahsxndev/instagram-clone?style=social)](https://github.com/ahsxndev/instagram-clone)

</div>

---

<div align="center">

**Built with ❤️ using Flutter & Firebase**

*Learn • Build • Share* 📸✨

</div>
