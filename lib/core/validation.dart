class Validator {
  /// Validates the provided name.
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!_isValidName(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  /// Validates the provided email address.
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!_isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates the provided password.
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  /// Validates the confirmation password.
  String? confirmPasswordValidator(String? value, String password) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates the provided OTP.
  String? otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    } else if (value.length != 4 || !_isNumeric(value)) {
      return 'OTP must be a 4-digit number';
    }
    return null;
  }

  /// Checks if a string is numeric.
  bool _isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  /// Checks if the provided name is valid.
  bool _isValidName(String value) {
    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    return nameRegex.hasMatch(value);
  }

  /// Checks if the provided email is valid.
  bool _isValidEmail(String value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(value);
  }
}
