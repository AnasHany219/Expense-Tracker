class User {
  int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int? verified;
  final String? otpCode;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.verified,
    this.otpCode,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      password: map['password'],
      verified: map['verified'],
      otpCode: map['otpCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'verified': verified,
      'otpCode': otpCode,
    };
  }
}
