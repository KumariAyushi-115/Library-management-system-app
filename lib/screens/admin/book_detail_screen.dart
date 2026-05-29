import 'package:flutter/material.dart';
import 'issued_book_user_screen.dart';
class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          book['title'],
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView( // Ensures everything is scrollable if screen is too small
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  book['cover_image'],
                  height: 180,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 18),

              /// TITLE
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu_book, size: 20),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "Title: ${book['title']}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),

              /// AUTHOR
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.edit, size: 20,color: Colors.grey[800],),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "Author: ${book['author']}",
                      style: TextStyle(fontSize: 18,color: Colors.black54),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              /// YEAR
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_today, size: 20,color: Colors.grey[800]),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "Published Year: ${book['publication_year']}",
                      style: TextStyle(fontSize: 18,color: Colors.black54),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              /// GENRE
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.category, size: 20,color: Colors.grey[800]),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "Genre: ${book['genre'].join(', ')}",
                      style: TextStyle(fontSize: 18,color: Colors.black54),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),

              /// DESCRIPTION HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.description, size: 20),
                  SizedBox(width: 6),
                  Text(
                    "Description:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),

              /// DESCRIPTION BODY
              Text(
                book['description'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              /// ISSUED INFO BUTTON
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IssuedUsersForBookScreen(
                        bookId: book['id'],
                        bookTitle: book['title'],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.info_outline),
                label: Text("Issued Info"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
