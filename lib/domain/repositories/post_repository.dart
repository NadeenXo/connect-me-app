import '../entities/post.dart';

abstract class PostRepository {
  Stream<List<Post>> getPosts();

  Future<void> createPost(Post post);
}
