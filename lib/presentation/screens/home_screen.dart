import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';
import '../blocs/auth_cubit.dart';
import '../blocs/post_cubit.dart';
import '../widgets/post_card.dart';
import '../../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PostCubit>()..loadPosts(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  Future<void> _showCreatePostDialog(BuildContext context) async {
    final contentController = TextEditingController();
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      contentController.dispose();
      return;
    }

    final authorName = await AuthService().getCurrentUserFullName();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Create Post'),
          content: TextField(
            controller: contentController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'What do you want to share?',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final content = contentController.text.trim();

                if (content.isEmpty) {
                  return;
                }

                await context.read<PostCubit>().addPost(
                  authorId: firebaseUser.uid,
                  authorName: authorName,
                  content: content,
                );

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );

    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConnectMe'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading || state is PostInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PostError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(state.message, textAlign: TextAlign.center),
              ),
            );
          }

          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('No posts yet. Create the first one!'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: state.posts[index]);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
