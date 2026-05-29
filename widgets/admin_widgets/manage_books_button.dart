import 'package:flutter/material.dart';
import '/screens/admin/books_screen.dart';

class ManageBooksButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.library_books, color: Colors.white),
        label: Text("Manage Books", style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => BooksScreen()));
        },
      ),
    );
  }
}
