import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  final Map<String, String> user;

  EditUserPage({required this.user});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController mobileController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    mobileController = TextEditingController(text: widget.user["Mobile Number"]);
    firstNameController = TextEditingController(text: widget.user["First Name"]);
    lastNameController = TextEditingController(text: widget.user["Last Name"]);
    emailController = TextEditingController(text: widget.user["Email ID"]);
    genderController = TextEditingController(text: widget.user["Gender"]);
  }

  void _updateUser() {
    Map<String, String> updatedUser = {
      "Mobile Number": mobileController.text,
      "First Name": firstNameController.text,
      "Last Name": lastNameController.text,
      "Email ID": emailController.text, // Email remains the same (acts as index)
      "Gender": genderController.text
    };

    Navigator.pop(context, updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: mobileController,
              decoration: InputDecoration(labelText: "Mobile Number"),
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email ID"),
              readOnly: true, // Email should not be changed
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: "Gender"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUser,
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
