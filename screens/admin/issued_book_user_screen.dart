import 'package:flutter/material.dart';
import '/database/db_helper.dart';

class IssuedUsersForBookScreen extends StatefulWidget {
  final int bookId;
  final String bookTitle;

  IssuedUsersForBookScreen({required this.bookId, required this.bookTitle});

  @override
  _IssuedUsersForBookScreenState createState() => _IssuedUsersForBookScreenState();
}

class _IssuedUsersForBookScreenState extends State<IssuedUsersForBookScreen> {
  List<Map<String, dynamic>> issuedUsers = [];

  @override
  void initState() {
    super.initState();
    fetchIssuedUsers();
  }

  Future<void> fetchIssuedUsers() async {
    final db = await DBHelper.initDB();
    final result = await db.rawQuery('''
      SELECT users.userId, users.userName, users.email, issued_books.issueDate, issued_books.returnDate
      FROM issued_books
      JOIN users ON users.userId = issued_books.userId
      WHERE issued_books.id = ?
    ''', [widget.bookId]);

    setState(() {
      issuedUsers = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo[400],
        title: Text("Title- ${widget.bookTitle}",style: TextStyle(
          fontSize: 20,fontWeight: FontWeight.bold,
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: issuedUsers.isEmpty
            ? Center(child: Text("📭 No users have issued this book yet."))
            : ListView.builder(
          itemCount: issuedUsers.length,
          itemBuilder: (context, index) {
            final user = issuedUsers[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(user['userName'], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, size: 16),
                        SizedBox(width: 6),
                        Text(user['email']),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.perm_identity, size: 16),
                        SizedBox(width: 6),
                        Text("ID: ${user['userId']}"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16),
                        SizedBox(width: 6),
                        Text("Issued: ${user['issueDate']}"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.update, size: 16),
                        SizedBox(width: 6),
                        Text("Return: ${user['returnDate']}"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
