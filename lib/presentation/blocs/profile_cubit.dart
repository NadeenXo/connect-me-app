import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String fullName;
  final String email;
  final String deviceModel;
  final String osVersion;
  final String? profileImageUrl;

  ProfileLoaded({
    required this.fullName,
    required this.email,
    required this.deviceModel,
    required this.osVersion,
    this.profileImageUrl,
  });
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ProfilePhotoUpdateError extends ProfileState {
  final String message;
  final ProfileLoaded previousProfile;

  ProfilePhotoUpdateError({
    required this.message,
    required this.previousProfile,
  });
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final user = _firebaseAuth.currentUser;

    if (user == null) {
      emit(ProfileError('No signed-in user was found.'));
      return;
    }

    String fullName = user.displayName ?? 'User';
    String? profileImageUrl;

    try {
      final userDocument = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      final userData = userDocument.data();

      if (userData != null) {
        fullName = userData['fullName']?.toString() ?? fullName;

        profileImageUrl = userData['profileImageUrl']?.toString();
      }
    } catch (_) {
      // Keep Firebase Auth values if the Firestore profile
      // cannot be loaded.
    }

    String deviceModel = 'Unknown device';
    String osVersion = 'Unknown OS';

    try {
      final deviceInformation = await _getDeviceInformation();

      deviceModel = deviceInformation.$1;
      osVersion = deviceInformation.$2;
    } catch (_) {
      // Keep fallback device information.
    }

    emit(
      ProfileLoaded(
        fullName: fullName,
        email: user.email ?? 'No email available',
        profileImageUrl: profileImageUrl,
        deviceModel: deviceModel,
        osVersion: osVersion,
      ),
    );
  }

  Future<void> updateProfilePhoto(XFile image) async {
    final currentState = state;

    if (currentState is! ProfileLoaded) {
      return;
    }

    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        emit(ProfileError('No signed-in user was found.'));
        return;
      }

      final imageBytes = await image.readAsBytes();

      final storageReference = _storage.ref().child(
        'profile_images/${user.uid}.jpg',
      );

      await storageReference.putData(
        imageBytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final downloadUrl = await storageReference.getDownloadURL();

      await _firestore.collection('users').doc(user.uid).set({
        'profileImageUrl': downloadUrl,
      }, SetOptions(merge: true));

      emit(
        ProfileLoaded(
          fullName: currentState.fullName,
          email: currentState.email,
          deviceModel: currentState.deviceModel,
          osVersion: currentState.osVersion,
          profileImageUrl: downloadUrl,
        ),
      );
    } catch (_) {
      emit(
        ProfilePhotoUpdateError(
          message: 'Unable to update your profile photo. Please try again.',
          previousProfile: currentState,
        ),
      );
    }
  }

  Future<(String, String)> _getDeviceInformation() async {
    final deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      final webInfo = await deviceInfo.webBrowserInfo;

      return (webInfo.browserName.name, webInfo.platform ?? 'Web');
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final androidInfo = await deviceInfo.androidInfo;

        return (androidInfo.model, 'Android ${androidInfo.version.release}');

      case TargetPlatform.iOS:
        final iosInfo = await deviceInfo.iosInfo;

        return (
          iosInfo.utsname.machine,
          '${iosInfo.systemName} ${iosInfo.systemVersion}',
        );

      default:
        return ('Unknown device', 'Unknown OS');
    }
  }
}
