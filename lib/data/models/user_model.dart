import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}

// Builder Pattern: creates a UserModel step by step using only provided fields.
class UserBuilder {
  String _id = '';
  String _fullName = '';
  String _email = '';
  String? _profileImageUrl;

  UserBuilder setId(String id) {
    _id = id;
    return this;
  }

  UserBuilder setFullName(String fullName) {
    _fullName = fullName;
    return this;
  }

  UserBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserBuilder setProfileImageUrl(String? profileImageUrl) {
    _profileImageUrl = profileImageUrl;
    return this;
  }

  UserModel build() {
    return UserModel(
      id: _id,
      fullName: _fullName,
      email: _email,
      profileImageUrl: _profileImageUrl,
    );
  }
}
