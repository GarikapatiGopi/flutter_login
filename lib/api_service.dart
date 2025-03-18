import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://reqres.in/api/register";
  final String loginBaseUrl = "http://bank-application-pbsu.onrender.com";

  Future<String> createUser(
    String mobile,
    String firstName,
    String lastName,
    String email,
    String password,
    String gender,
  ) async {
    final url = Uri.parse(baseUrl);

    final Map<String, dynamic> requestBody = {
      "mobile_number": mobile,
      "first_name": firstName,
      "last_name": lastName,
      "email_id": email,
      "password": password,
      "gender": gender
    };

    log("Sending Request to: $url");
    log("Request Body: ${jsonEncode(requestBody)}");

    try {
      log('here');
      final response = await http.post(
        url,
        
        body: jsonEncode(requestBody),
      );

      log("Response Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "User created successfully";
      } else {
        final responseData = jsonDecode(response.body);
        return responseData["message"] ?? "Signup failed";
      }
    } catch (e,s) {
            log(e.toString(), stackTrace: s);

      return "An error occurred: $e";
    }
  }
  Future<String> loginUser(String mobile, String password) async {
    final url = Uri.parse("$loginBaseUrl/user/login");

    final Map<String, dynamic> requestBody = {
      "mobile_number": mobile,
      "password": password,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return "Login successful";
      } else {
        final responseData = jsonDecode(response.body);
        return responseData["message"] ?? "Login failed";
      }
    } catch (e,s) {
      log(e.toString(), stackTrace: s);
      return "An error occurred: $e";
    }
  }
}
