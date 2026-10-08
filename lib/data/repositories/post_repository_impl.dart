import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/firestore_post_datasource.dart';
import '../datasources/local_post_datasource.dart';
import '../models/post_model.dart';

enum PostDataSourceType { remote, local }

class PostRepositoryImpl implements PostRepository {
  final FirestorePostDataSource firestorePostDataSource;
  final LocalPostDataSource localPostDataSource;
  final PostDataSourceType dataSourceType;

  PostRepositoryImpl({
    required this.firestorePostDataSource,
    required this.localPostDataSource,
    required this.dataSourceType,
  });

  @override
  Stream<List<Post>> getPosts() {
    if (dataSourceType == PostDataSourceType.remote) {
      return firestorePostDataSource.getPosts();
    }

    return Stream.fromFuture(localPostDataSource.getCachedPosts());
  }

  @override
  Future<void> createPost(Post post) async {
    final postModel = PostModel(
      id: post.id,
      authorId: post.authorId,
      authorName: post.authorName,
      content: post.content,
      createdAt: post.createdAt,
    );

    if (dataSourceType == PostDataSourceType.remote) {
      await firestorePostDataSource.createPost(postModel);
      return;
    }

    await localPostDataSource.addPost(postModel);
  }
}

// Factory Pattern: selects which post datasource the repository should use

class PostRepositoryFactory {
  static PostRepository create({
    required PostDataSourceType type,
    required FirestorePostDataSource firestorePostDataSource,
    required LocalPostDataSource localPostDataSource,
  }) {
    return PostRepositoryImpl(
      firestorePostDataSource: firestorePostDataSource,
      localPostDataSource: localPostDataSource,
      dataSourceType: type,
    );
  }
}
