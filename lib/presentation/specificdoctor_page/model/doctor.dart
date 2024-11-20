class Doctor {
  final int id;
  final String name;
  final String email;
  final String role;
  final String phoneNumber;
  final String profilePicture;
  final String address;
  final int ages;
  final String gender;
  final String description;
  final int rating;
  final int strNumber;
  final String school;
  final String experience;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.profilePicture,
    required this.address,
    required this.ages,
    required this.gender,
    required this.description,
    required this.rating,
    required this.strNumber,
    required this.school,
    required this.experience,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
      address: json['address'],
      ages: json['ages'],
      gender: json['gender'],
      description: json['description'],
      rating: json['rating'],
      strNumber: json['str_number'],
      school: json['school'],
      experience: json['experience'],
    );
  }
}
