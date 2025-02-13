import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool otpSent = false;

  Future<void> sendOtp() async {
    try {
      print("Sending OTP to: ${phoneController.text}");
      await ApiService().createOtp(phoneController.text);
      setState(() => otpSent = true);
    } catch (e) {
      print("Error sending OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP")),
      );
    }
  }

  Future<void> verifyOtp() async {
    try {
      await ApiService().validateOtp(phoneController.text, otpController.text);
      // For demo purposes, you can mark the user as logged in here.
      // In a real app, update SharedPreferences accordingly.
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error verifying OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP verification failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login with OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Mobile Number"),
            ),
            if (otpSent)
              TextField(
                controller: otpController,
                decoration: const InputDecoration(labelText: "Enter OTP"),
              ),
            ElevatedButton(
              onPressed: otpSent ? verifyOtp : sendOtp,
              child: Text(otpSent ? "Verify OTP" : "Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
