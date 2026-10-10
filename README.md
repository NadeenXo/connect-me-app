# ConnectMe Community App

ConnectMe is a Flutter community/social application built as a capstone project using Firebase, Clean Architecture, BLoC/Cubit state management, dependency injection, native device features, Google Maps, and Firebase App Distribution.

## GitHub

Repository: https://github.com/NadeenXo/connect-me-app

## Features

- Firebase Authentication with Email/Password
- Sign Up form validation
- Persistent authentication state
- Real-time community posts from Cloud Firestore
- Create new community posts
- Profile screen
- Profile image selection using `image_picker`
- Profile image storage using Firebase Storage
- Biometric authentication before opening the Profile screen
- Community Map using Google Maps
- Three hardcoded community member markers
- Marker info windows showing member name and city
- Clean Architecture
- BLoC/Cubit state management
- GetIt dependency injection
- Builder, Factory, and Singleton design patterns
- Responsive UI using `MediaQuery`
- User-friendly Firebase and network error handling

## Technologies

- Flutter
- Dart
- Firebase Core
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase App Distribution
- `flutter_bloc`
- `get_it`
- `image_picker`
- `google_maps_flutter`
- `local_auth`
- `device_info_plus`

## Architecture

The project follows Clean Architecture with clear separation between the Data, Domain, Presentation, and Services layers.

```text
lib/
├── main.dart
├── injection.dart
├── core/
│   └── errors/
│       └── failures.dart
├── data/
│   ├── datasources/
│   │   ├── firestore_post_datasource.dart
│   │   └── local_post_datasource.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   └── post_model.dart
│   └── repositories/
│       └── post_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── user.dart
│   │   └── post.dart
│   ├── repositories/
│   │   └── post_repository.dart
│   └── usecases/
│       ├── get_posts.dart
│       └── create_post.dart
├── presentation/
│   ├── blocs/
│   │   ├── auth_cubit.dart
│   │   ├── post_cubit.dart
│   │   └── profile_cubit.dart
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── sign_up_screen.dart
│   │   ├── home_screen.dart
│   │   ├── profile_screen.dart
│   │   └── map_screen.dart
│   └── widgets/
│       ├── post_card.dart
│       └── member_marker.dart
└── services/
    ├── firestore_service.dart
    ├── auth_service.dart
    └── biometric_service.dart
```

## Clean Architecture Flow

```text
Screen
  ↓
Cubit
  ↓
Use Case
  ↓
Repository
  ↓
Data Source
  ↓
Firebase / Local Source
```

## Design Patterns

### Builder Pattern

The Builder Pattern is used to construct the user profile step by step during sign up.

### Factory Pattern

The Factory Pattern is used by the post repository to select the correct post data source.

### Singleton Pattern

`FirestoreService` uses the Singleton Pattern so only one shared Firestore service instance is used during the application lifecycle.

## Authentication

Firebase Authentication is used for:

- Sign Up
- Login
- Logout
- Persistent authentication state

### Sign Up Validation

The Sign Up form validates:

- Full Name is required
- Full Name begins with a capital letter
- Email contains `@`
- Password contains at least 6 characters
- Confirm Password matches Password

Firebase errors are converted into user-friendly UI messages.

## Firestore Posts

Community posts are stored in Cloud Firestore.

The Home Feed listens to Firestore in real time using `PostCubit`.

## Profile

The Profile screen displays:

- Profile photo
- Full name
- Email
- Device model
- OS version

`device_info_plus` is used to retrieve device information.

`image_picker` is used to select a profile photo from the gallery.

Firebase Storage stores the image, while Firestore stores the image download URL.

## Biometrics

The Profile screen is protected by biometric authentication using `local_auth`.

Flow:

```text
Home
  ↓
Tap Profile
  ↓
Biometric Authentication
  ↓
Success
  ↓
Profile Screen
```

Biometric authentication is tested on Android because browser builds do not provide the same biometric flow.

## Community Map

The Community Map is built with `google_maps_flutter`.

It contains at least three member markers:

- Nadeen — Cairo
- Omar — Alexandria
- Sara — Giza

Tapping a marker displays an info window containing the member name and city.

## Android Permissions

The app uses the following Android permissions/configuration:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
```

Google Maps also requires the Maps API key inside the Android application configuration.

Gallery selection is handled through `image_picker` and the platform image picker.

## Google Maps Setup

For Android, add the Google Maps API key inside:

```text
android/app/src/main/AndroidManifest.xml
```

Example:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

For web testing, the Maps JavaScript API must also be enabled.

> Do not commit unrestricted production API keys to a public repository.

## Firebase Setup

The project uses:

- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase App Distribution

FlutterFire configuration is generated using:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Firebase is initialized from `main.dart` using `firebase_options.dart`.

## Dependency Injection

GetIt is configured in:

```text
lib/injection.dart
```

It provides dependencies such as:

- `AuthService`
- `FirestoreService`
- `FirestorePostDataSource`
- `LocalPostDataSource`
- `PostRepository`
- `GetPosts`
- `CreatePost`
- `PostCubit`
- `ProfileCubit`
- `BiometricService`

## Responsive UI

The screens use `MediaQuery` to adjust spacing and layout for different screen widths.

## Error Handling

Firebase, network, profile, and post errors are caught and converted into readable messages.

Examples:

```text
The email or password is incorrect.
Please check your internet connection.
Unable to load posts. Please try again.
Unable to update your profile photo. Please try again.
```

Unhandled Firebase exceptions are not intentionally exposed directly to the user.

## Screenshots

Project screenshots are stored in:

```text
screenshots/
```

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

The final Android release will be distributed using Firebase App Distribution.

### Distribution Process

1. Build the release APK:

```bash
flutter build apk --release
```

2. Open Firebase Console.
3. Go to **App Distribution**.
4. Upload the generated release APK.
5. Add at least two tester email addresses.
6. Create/review release notes.
7. Distribute the build.
8. Confirm the testers receive the invitation.
9. Capture screenshots of:
   - App Distribution dashboard showing the uploaded APK and two testers
   - Tester invitation email

The release APK is generated at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

> The App Distribution screenshots should be added after the release APK has been uploaded and tester invitations have been sent.


## Build APK

Debug APK:

```bash
flutter build apk --debug
```

Release APK:

```bash
flutter build apk --release
```

The project follows these code-quality rules:

- Clear class, function, widget, and variable names
- One major screen/model/use case/repository/widget per Dart file
- Shared logic extracted into services, repositories, or use cases
- No unnecessary duplicate logic
- Firebase/network exceptions are handled
- `fromJson` and `toJson` are used for Firestore models
- Unused imports and packages should be removed before final submission

## Final Deliverables Checklist

- [x] Public GitHub repository
- [x] Clean Architecture project structure
- [x] Firebase Authentication
- [x] Cloud Firestore Home Feed
- [x] BLoC/Cubit state management
- [x] GetIt dependency injection
- [x] Builder Pattern
- [x] Factory Pattern
- [x] Singleton Pattern
- [x] Google Maps with member markers
- [x] Device information
- [x] Profile image implementation
- [x] Android debug APK build
- [ ] Login screenshot
- [ ] Sign Up screenshot
- [x] Home Feed screenshot
- [ ] Biometric prompt screenshot
- [ ] Profile screenshot
- [x] Community Map screenshot
- [ ] Release APK
- [ ] Firebase App Distribution with two testers
- [ ] App Distribution screenshot
- [ ] Tester invitation screenshot

