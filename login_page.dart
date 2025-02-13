import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:oruphones/common/app_images.dart';
import 'package:oruphones/pages/otp_page.dart';
import 'dart:convert';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  Future<void> sendOtp(BuildContext context) async {
    final String url = "http://40.90.224.241:5000/login/otpCreate";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "countryCode": 91,
        "mobileNumber": int.parse(phoneController.text)
      }),
    );

    //print("Response Code: ${response.statusCode}");
    //print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: phoneController.text),),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP: ${response.body}")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(AppImages.logo, height: 80)),
            const SizedBox(height: 24),
            const Text("Welcome", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Sign in to continue", style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixText: "+91 ",
                hintText: "Mobile Number",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                const Text("Accept Terms and Conditions"),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => sendOtp(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                child: const Text("Next", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
