import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://40.90.224.241:5000';


  String? _csrfToken;
  String? _cookie;


  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();


  Future<void> fetchSession() async {
    final url = Uri.parse('$_baseUrl/isLoggedIn');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final setCookie = response.headers['set-cookie'];
      if (setCookie != null) {
        _cookie = setCookie.split(';').first;
      }
      final body = jsonDecode(response.body);
      _csrfToken = body['csrfToken'];
    } else {
      throw Exception('Failed to fetch session data');
    }
  }


  Future<void> createOtp(String mobileNumber) async {
    final url = Uri.parse('$_baseUrl/login/otpCreate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "countryCode": 91,
        "mobileNumber": mobileNumber,
      }),
    );
    print("OTP Create response status: ${response.statusCode}");
    print("OTP Create response body: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception('Failed to create OTP');
    }
  }


  Future<void> validateOtp(String mobileNumber, String otp) async {
    final url = Uri.parse('$_baseUrl/login/otpValidate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "countryCode": 91,
        "mobileNumber": mobileNumber,
        "otp": otp,
      }),
    );
    print("OTP Validate response status: ${response.statusCode}");
    print("OTP Validate response body: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception('Failed to validate OTP');
    }
    
    await fetchSession();
  }


  Future<void> logout() async {
    final url = Uri.parse('$_baseUrl/logout');
    final response = await http.get(
      url,
      headers: {
        if (_csrfToken != null) 'X-Csrf-Token': _csrfToken!,
        if (_cookie != null) 'Cookie': _cookie!,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
    _csrfToken = null;
    _cookie = null;
  }


  Future<void> updateUser(String userName) async {
    final url = Uri.parse('$_baseUrl/update');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (_csrfToken != null) 'X-Csrf-Token': _csrfToken!,
        if (_cookie != null) 'Cookie': _cookie!,
      },
      body: jsonEncode({
        "countryCode": 91,
        "userName": userName,
      }),
    );
    print("Update User response status: ${response.statusCode}");
    print("Update User response body: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }
}
