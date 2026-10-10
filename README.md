# ConnectMe Community App

ConnectMe is a Flutter community app built with Firebase, Clean Architecture, BLoC/Cubit, GetIt, Google Maps, biometrics, device info, and Firebase App Distribution.

## GitHub

https://github.com/NadeenXo/connect-me-app

## Features

- Firebase Email/Password authentication
- Sign Up validation
- Persistent login
- Real-time Firestore posts
- Create community posts
- Profile screen with photo, name, email, device model, and OS version
- Profile image upload with Firebase Storage
- Biometric authentication using `local_auth`
- Community Map with 3 member markers and info windows
- Responsive UI using `MediaQuery`
- User-friendly Firebase/network error handling

## Architecture

The project follows Clean Architecture:

```text
lib/
├── main.dart
├── injection.dart
├── core/
├── data/
├── domain/
├── presentation/
└── services/
```

Flow:

```text
Screen
→ Cubit
→ Use Case
→ Repository
→ Data Source
→ Firebase
```

## Design Patterns

- **Builder Pattern** — used for user profile construction
- **Factory Pattern** — used for post data source selection
- **Singleton Pattern** — used for `FirestoreService`
- **GetIt** — used for dependency injection

## Main Packages

- `firebase_auth`
- `cloud_firestore`
- `firebase_storage`
- `flutter_bloc`
- `get_it`
- `google_maps_flutter`
- `local_auth`
- `image_picker`
- `device_info_plus`

## Android Permissions

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
```

## Screenshots

### Login
![Login](screenshots/login.png)

### Sign Up
![Sign Up](screenshots/signup.png)

### Home Feed
![Home Feed](screenshots/home_feed.png)

### Biometric Authentication
![Biometric Authentication](screenshots/biometric_prompt.png)

### Profile
![Profile](screenshots/profile.png)

### Community Map
![Community Map](screenshots/community_map.png)

### Firebase App Distribution
![Firebase App Distribution](screenshots/app_distribution.png)

### Tester Invitation
![Tester Invitation](screenshots/tester_invitation.png)

## Firebase App Distribution

Build the release APK:

```bash
flutter build apk --release
```

APK location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Then:

1. Open Firebase Console
2. Go to **App Distribution**
3. Upload the APK
4. Add at least 2 testers
5. Distribute the build
6. Take screenshots of the release dashboard and tester invitation email

## Final Checks

```bash
dart format .
flutter analyze
flutter build apk --release
```

## Deliverables

- Public GitHub repository
- Login and Sign Up screenshots
- Home Feed screenshot
- Biometric prompt screenshot
- Profile screenshot with photo and device info
- Community Map screenshot with open info window
- Firebase App Distribution screenshot with 2 testers
- Tester invitation email screenshot
