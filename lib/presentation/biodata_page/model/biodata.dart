class UserProfile {
  final int id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profilePicture;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
    );
  }
}
