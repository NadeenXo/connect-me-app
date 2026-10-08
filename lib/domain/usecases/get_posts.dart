import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPosts {
  final PostRepository postRepository;

  GetPosts(this.postRepository);

  Stream<List<Post>> call() {
    return postRepository.getPosts();
  }
}
