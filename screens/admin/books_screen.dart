import 'package:flutter/material.dart';
import '/services/api_service.dart';
import 'book_detail_screen.dart';
import '/widgets/admin_widgets/bottom_nav_bar.dart';
import 'members_screen.dart';
import 'requests_screen.dart';
import 'settings_screen.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  int _selectedIndex=0;
  /// **Navigation Handler**
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.pushReplacement(
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

  List<dynamic> books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() async {
    try {
      List<dynamic> bookData = await ApiService.fetchBooks();
      setState(() {
        books = bookData;
      });
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(Icons.menu_book, size: 24),
            SizedBox(width: 8),
            Text("List of Books",style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: books.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.indigo[50],
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text("${index + 1}. ${books[index]['title']}"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(book: books[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );

  }
}
