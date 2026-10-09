import 'package:connectme_app/presentation/blocs/profile_cubit.dart';
import 'package:connectme_app/services/biometric_service.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/firestore_post_datasource.dart';
import 'data/datasources/local_post_datasource.dart';
import 'data/repositories/post_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/usecases/create_post.dart';
import 'domain/usecases/get_posts.dart';
import 'presentation/blocs/post_cubit.dart';
import 'services/firestore_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());

  getIt.registerLazySingleton<FirestorePostDataSource>(
    () => FirestorePostDataSource(getIt<FirestoreService>()),
  );

  getIt.registerLazySingleton<LocalPostDataSource>(() => LocalPostDataSource());

  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryFactory.create(
      type: PostDataSourceType.remote,
      firestorePostDataSource: getIt<FirestorePostDataSource>(),
      localPostDataSource: getIt<LocalPostDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetPosts>(
    () => GetPosts(getIt<PostRepository>()),
  );

  getIt.registerLazySingleton<CreatePost>(
    () => CreatePost(getIt<PostRepository>()),
  );

  getIt.registerFactory<PostCubit>(
    () =>
        PostCubit(getPosts: getIt<GetPosts>(), createPost: getIt<CreatePost>()),
  );

  getIt.registerFactory<ProfileCubit>(() => ProfileCubit());

  getIt.registerLazySingleton<BiometricService>(() => BiometricService());
}
