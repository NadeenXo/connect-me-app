import '../models/post_model.dart';

class LocalPostDataSource {
  final List<PostModel> _cachedPosts = [];

  Future<List<PostModel>> getCachedPosts() async {
    return List.unmodifiable(_cachedPosts);
  }

  Future<void> cachePosts(List<PostModel> posts) async {
    _cachedPosts
      ..clear()
      ..addAll(posts);
  }

  Future<void> addPost(PostModel post) async {
    _cachedPosts.add(post);
  }
}
