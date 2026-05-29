import 'package:flutter/material.dart';
import '/screens/auth/login_screen.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Row(
              children: [
                Icon(Icons.library_books, size: 40, color: Colors.white),
                SizedBox(width: 20),
                Text(
                  "ADMIN HANDLES",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          _buildDrawerItem(context, Icons.dashboard, "Dashboard"),
          _buildDrawerItem(context, Icons.category, "Categories"),
          _buildDrawerItem(context, Icons.book, "Books Inventory"),
          _buildDrawerItem(context, Icons.assignment, "Manage Issued Books"),
          _buildDrawerItem(context, Icons.people, "Manage Users"),
          _buildDrawerItem(context, Icons.settings, "Settings"),
          Spacer(), // Pushes log out button to the bottom
          //Divider(),
          Container(
            color: Colors.indigo[50],
            child: ListTile(

              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Log Out", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginScreen()),
                ); // Redirect to login screen
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title) {
    return ListTile(

      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: () {
        // Handle navigation here
      },
    );
  }
}
