import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(

        title: const Text("My Profile", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: false,
        backgroundColor: Colors.blue[600],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 28),
            // Top Container
               Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent.withOpacity(0.2), // Optional background
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue[700], // You can change this to match your theme
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "John Doe",
                    style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Edit profile logic
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),


            // Information Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [

                  _buildInfoTile("Full Name", "John Doe", Icons.person),
                  _buildInfoTile("Email", "johndoe@example.com", Icons.email),
                  _buildInfoTile("Phone", "+91 9876543210", Icons.phone),
                  _buildInfoTile("Address", "123, Main Street, Delhi", Icons.home),
                  _buildInfoTile("Change Password", "********", Icons.lock, onTap: () {
                    // Navigate to password change screen
                  }),

                 // const SizedBox(height: 20),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      subtitle: Text(value),
      trailing: onTap != null ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }
}
