class User {
  int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool verified;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.verified = false,
  });

  /// Constructs a new instance of [User] from a map representation.
  ///
  /// This factory constructor is commonly used when retrieving user data from a database or from serialized data formats like JSON.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      password: map['password'],
      verified: map['verified'] == 1,
    );
  }

  /// Converts the user object into a map representation.
  ///
  /// This method is useful for database operations or serialization, where the user data needs to be represented as a map before being stored or transmitted.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'verified': verified ? 1 : 0,
    };
  }
}
