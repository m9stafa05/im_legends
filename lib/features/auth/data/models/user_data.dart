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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'age': age,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      age: map['age'],
      profileImageUrl: map['profileImageUrl'],
    );
  }
}
