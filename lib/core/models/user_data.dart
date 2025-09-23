class UserData {
  final String name;
  final String email;
  final String phoneNumber;
  final int age;
  final String? profileImageUrl;

  UserData({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.age,
    this.profileImageUrl,
  });

  /// Factory for creating a UserData object from a Supabase map
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      age: map['age'] ?? 0,
      profileImageUrl: map['profile_image'],
    );
  }

  /// Converts UserData into a map for inserting/updating Supabase
  Map<String, dynamic> toMap(String uid) {
    return {
      'id': uid,
      'name': name,
      'phone_number': phoneNumber,
      'age': age,
      'email': email,
      'profile_image': profileImageUrl,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  UserData copyWith({String? profileImageUrl}) {
    return UserData(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      age: age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
