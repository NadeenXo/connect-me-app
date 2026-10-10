import '../../services/firestore_service.dart';
import '../models/post_model.dart';

class FirestorePostDataSource {
  final FirestoreService firestoreService;

  FirestorePostDataSource(this.firestoreService);

  Stream<List<PostModel>> getPosts() {
    return firestoreService.firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((document) {
            final data = document.data();

            return PostModel.fromJson({...data, 'id': document.id});
          }).toList(),
        );
  }

  Future<void> createPost(PostModel post) async {
    final documentReference = firestoreService.firestore
        .collection('posts')
        .doc();

    final postWithId = PostModel(
      id: documentReference.id,
      authorId: post.authorId,
      authorName: post.authorName,
      content: post.content,
      createdAt: post.createdAt,
    );

    await documentReference.set(postWithId.toJson());
  }
}
