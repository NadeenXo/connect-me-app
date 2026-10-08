class User {
  final String id;
  final String fullName;
  final String email;
  final String? profileImageUrl;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImageUrl,
  });
}
