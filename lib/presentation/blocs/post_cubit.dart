import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';
import '../../domain/usecases/create_post.dart';
import '../../domain/usecases/get_posts.dart';

sealed class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}

class PostCubit extends Cubit<PostState> {
  final GetPosts getPosts;
  final CreatePost createPost;

  StreamSubscription<List<Post>>? _postsSubscription;

  PostCubit({required this.getPosts, required this.createPost})
    : super(PostInitial());

  void loadPosts() {
    emit(PostLoading());

    _postsSubscription?.cancel();

    _postsSubscription = getPosts().listen(
      (posts) {
        emit(PostLoaded(posts));
      },
      onError: (_) {
        emit(PostError('Unable to load posts. Please try again.'));
      },
    );
  }

  Future<void> addPost({
    required String authorId,
    required String authorName,
    required String content,
  }) async {
    try {
      final post = Post(
        id: '',
        authorId: authorId,
        authorName: authorName,
        content: content.trim(),
        createdAt: DateTime.now(),
      );

      await createPost(post);
    } catch (_) {
      emit(PostError('Unable to create the post. Please try again.'));
    }
  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }
}
