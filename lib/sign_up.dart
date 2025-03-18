import 'package:flutter/material.dart';
import 'api_service.dart'; // Import API service
import 'dart:convert';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedGender;
  final ApiService apiService = ApiService();

 void registerUser() async {
  if (_selectedGender == null) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Error"),
              content: Text("Please select a gender"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            ));
    return;
  }

  String responseMessage = await apiService.createUser(
  _mobileController.text,
  _firstNameController.text,
  _lastNameController.text,
  _emailController.text,
  _passwordController.text,
  _selectedGender!.toUpperCase(),
);

  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(responseMessage == "User created successfully"
                ? "Success"
                : "Error"),
            content: Text(responseMessage),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("OK"))
            ],
          ));

  if (responseMessage == "User created successfully") {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _passwordController.clear();
    setState(() {
      _selectedGender = null;
    });
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup - Apicrud"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "First name is required" : null,
              ),
              SizedBox(height: 10),

              // Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Last name is required" : null,
              ),
              SizedBox(height: 10),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) return "Email is required";
                  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                  return emailRegex.hasMatch(value) ? null : "Enter a valid email";
                },
              ),
              SizedBox(height: 10),

              // Mobile Number
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: "Mobile",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value!.isEmpty) return "Mobile number is required";
                  return value.length == 10 ? null : "Mobile number must be 10 digits";
                },
              ),
              SizedBox(height: 10),

              // Gender Selection with Checkboxes
              Text("Gender:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Checkbox(
                    value: _selectedGender == "MALE",
                    onChanged: (value) => setState(() => _selectedGender = value! ? "MALE" : null),
                  ),
                  Text("Male"),
                  Checkbox(
                    value: _selectedGender == "FEMALE",
                    onChanged: (value) => setState(() => _selectedGender = value! ? "FEMALE" : null),
                  ),
                  Text("Female"),
                  Checkbox(
                    value: _selectedGender == "TRANS",
                    onChanged: (value) => setState(() => _selectedGender = value! ? "TRANS" : null),
                  ),
                  Text("Trans"),
                ],
              ),
              SizedBox(height: 10),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
              ),
              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF08080),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    }
                  },
                  child: Text("Sign Up", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
