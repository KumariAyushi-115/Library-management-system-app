import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '/widgets/admin_widgets/bottom_nav_bar.dart';
import 'user_detail_screen.dart';
import 'settings_screen.dart';
import 'requests_screen.dart';
import 'books_screen.dart';

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  int _selectedIndex = 0;
  /// **Navigation Handler**
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BooksScreen()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MembersScreen()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => RequestsScreen()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SettingsScreen()));
        break;
    }
  }

  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    String data = await rootBundle.loadString('assets/registered_users.json');
    setState(() {
      users = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Icon(Icons.people),
            SizedBox(width: 8),
            Text("Registered Users",style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: users.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(users[index]['userName'][0], style: TextStyle(color: Colors.white)),
              ),
              title: Text(users[index]['userName']),
              subtitle: Text(users[index]['email']),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(userData: users[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ), // Members Index
    );
  }
}
