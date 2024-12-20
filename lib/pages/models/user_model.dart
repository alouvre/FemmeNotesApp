class UserModel {
  String fullName;
  String username;
  String email;

  UserModel({
    required this.fullName,
    required this.username,
    required this.email,
  });

  // Fungsi untuk mendapatkan nama depan
  String get firstName => fullName.split(' ').first;
}
