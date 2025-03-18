import 'package:flutter/material.dart';
import 'Edituserpage.dart'; // Import the Edit Page

class UserDetailsPage extends StatefulWidget {
  final Map<String, dynamic> userData;

   UserDetailsPage({Key? key, required this.userData}) : super(key: key);
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  
  List<Map<String, String>> users = [
    {
      "Mobile Number": "7093498038",
      "First Name": "Gopi",
      "Last Name": "Garikapati",
      "Email ID": "garikapatigopi00@gmail.com",
      "Gender": "MALE"
    },
    {
      "Mobile Number": "9876543210",
      "First Name": "Rahul",
      "Last Name": "Sharma",
      "Email ID": "rahul@example.com",
      "Gender": "MALE"
    },
    {
      "Mobile Number": "9123456789",
      "First Name": "Priya",
      "Last Name": "Verma",
      "Email ID": "priya@example.com",
      "Gender": "FEMALE"
    }
  ];

  void _editUser(String email) async {
    Map<String, String>? updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(
          user: users.firstWhere((user) => user["Email ID"] == email),
        ),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        int index = users.indexWhere((user) => user["Email ID"] == email);
        users[index] = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 30,
              columns: [
                DataColumn(label: Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Last Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Email ID', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Gender', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: users.map((user) {
                return DataRow(cells: [
                  DataCell(Text(user["Mobile Number"]!)),
                  DataCell(Text(user["First Name"]!)),
                  DataCell(Text(user["Last Name"]!)),
                  DataCell(Text(user["Email ID"]!)),
                  DataCell(Text(user["Gender"]!)),
                  DataCell(
                    ElevatedButton(
                      onPressed: () => _editUser(user["Email ID"]!),
                      child: Text("Edit"),
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
