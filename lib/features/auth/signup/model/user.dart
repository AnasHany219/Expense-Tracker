class User {
  // Properties
  int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int? verified;
  final String? otpCode;

  // Constructor
  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.verified,
    this.otpCode,
  });

  /// Factory method to create a User object from a map.
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

  /// Converts the User object to a map.
  ///
  /// Returns:
  /// A map representation of the User object.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'verified': 0, // Default to 0 if not provided
      'otpCode': otpCode,
    };
  }
}
