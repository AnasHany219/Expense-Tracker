class Validator {
  String? nameValidator(String? value) {
    // Regular expression for firstname and lastname validation
    final nameRegex = RegExp(r'^[a-zA-Z]+$');

    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!nameRegex.hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? emailValidator(String? value) {
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value, String password) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? otpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    } else if (value.length != 4 || !isNumeric(value)) {
      return 'OTP must be a 4-digit number';
    }
    return null;
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
