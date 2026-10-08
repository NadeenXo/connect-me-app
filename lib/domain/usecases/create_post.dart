import '../entities/post.dart';
import '../repositories/post_repository.dart';

class CreatePost {
  final PostRepository postRepository;

  CreatePost(this.postRepository);

  Future<void> call(Post post) async {
    await postRepository.createPost(post);
  }
}
