abstract class Failure {
  final String message;

  const Failure(this.message);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
