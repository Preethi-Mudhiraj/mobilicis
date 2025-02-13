import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:oruphones/common/app_images.dart';
import 'package:oruphones/pages/confirm_name_screen.dart';
import 'package:oruphones/pages/home_screen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final String phoneNumber;

  OtpScreen({required this.phoneNumber});

  Future<void> verifyOtp(BuildContext context) async {
    const String url = "http://40.90.224.241:5000/login/otpValidate";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "countryCode": 91,
          "mobileNumber": int.parse(phoneNumber),
          "otp": int.parse(otpController.text),
        }),
      );

      print("Response Code: \${response.statusCode}");
      print("Response Body: \${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == "SUCCESS") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Verified Successfully!")),
        );


        final user = data["user"] ?? {};
        final userName = user["userName"]?.toString().trim() ?? "";


        if (userName.isEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ConfirmNameScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP Verification Failed: ${data["reason"] ?? "Invalid OTP"}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error verifying OTP: \$e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Verify Mobile No."),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset(AppImages.logo, height: 80)),
            const SizedBox(height: 24),
            const Text("Please enter the 4-digit verification code sent to your mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            Pinput(
              length: 4,
              controller: otpController,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: () {}, child: const Text("Resend OTP in 0:23 sec")),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => verifyOtp(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                child: const Text("Verify OTP", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
