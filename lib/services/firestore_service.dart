import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Singleton Pattern: keeps one shared FirestoreService instance throughout app lifecycle.
  FirestoreService._internal();

  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}
