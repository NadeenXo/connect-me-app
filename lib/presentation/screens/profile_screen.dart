import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../injection.dart';
import '../blocs/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickProfileImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    await context.read<ProfileCubit>().updateProfilePhoto(image);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final horizontalPadding = screenWidth > 600 ? screenWidth * 0.2 : 24.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfilePhotoUpdateError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(state.message, textAlign: TextAlign.center),
                ),
              );
            }

            ProfileLoaded? profile;

            if (state is ProfileLoaded) {
              profile = state;
            } else if (state is ProfilePhotoUpdateError) {
              profile = state.previousProfile;
            }

            if (profile == null) {
              return const SizedBox.shrink();
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage:
                        profile.profileImageUrl != null &&
                            profile.profileImageUrl!.isNotEmpty
                        ? NetworkImage(profile.profileImageUrl!)
                        : null,
                    child:
                        profile.profileImageUrl == null ||
                            profile.profileImageUrl!.isEmpty
                        ? const Icon(Icons.person, size: 55)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _pickProfileImage,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Update Profile Photo'),
                  ),
                  const SizedBox(height: 32),
                  _ProfileInfoTile(
                    icon: Icons.person,
                    title: 'Full Name',
                    value: profile.fullName,
                  ),
                  const SizedBox(height: 12),
                  _ProfileInfoTile(
                    icon: Icons.email,
                    title: 'Email',
                    value: profile.email,
                  ),
                  const SizedBox(height: 12),
                  _ProfileInfoTile(
                    icon: Icons.phone_android,
                    title: 'Device Model',
                    value: profile.deviceModel,
                  ),
                  const SizedBox(height: 12),
                  _ProfileInfoTile(
                    icon: Icons.settings,
                    title: 'OS Version',
                    value: profile.osVersion,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
