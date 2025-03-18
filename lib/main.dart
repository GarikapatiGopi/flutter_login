import 'package:flutter/material.dart';
import 'login_page.dart';
import 'user_details.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserDetailsPage(
      userData: {
        "mobile_number": "7093498038",
        "first_name": "Gopi",
        "last_name": "Garikapati",
        "email_id": "garikapatigopi00@gmail.com",
        "gender": "MALE"
      },
    ),
  ));
}

class ApicrudApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "apicrud",
      home: LoginPage(), // Start with Login Page
    );
  }
}
