import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailSender {
  // Load email username and password from .env file
  static final String username = dotenv.env['EMAIL_USERNAME']!;
  static final String password = dotenv.env['EMAIL_PASSWORD']!;

  String generateOTP() {
    int otp = Random().nextInt(9000) + 1000;
    return otp.toString();
  }

  Future<void> sendOTP(String userEmail) async {
    final smtpServer = gmail(username, password);

    // Generate OTP
    final otp = generateOTP();

    // Create the email message
    final message = Message()
      ..from = Address(username)
      ..recipients.add(userEmail)
      ..subject = 'OTP Verification Code'
      ..text = 'Your OTP verification code is: $otp';
    await send(message, smtpServer);
  }
}
