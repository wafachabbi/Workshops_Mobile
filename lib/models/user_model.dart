// Simple in-memory user store
class UserModel {
  String username;
  String email;
  String password;
  String address;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    this.address = '',
  });
}

// Global current user (set after sign-up or sign-in)
UserModel? currentUser;

// Registered users list
List<UserModel> registeredUsers = [];
