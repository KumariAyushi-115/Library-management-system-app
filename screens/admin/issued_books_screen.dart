import 'package:flutter/material.dart';
import '/database/issued_books_repo.dart';
import '/models/issued_book.dart';

class IssuedBooksScreen extends StatefulWidget {
  @override
  _IssuedBooksScreenState createState() => _IssuedBooksScreenState();
}

class _IssuedBooksScreenState extends State<IssuedBooksScreen> {
  List<IssuedBook> issuedBooks = [];

  @override
  void initState() {
    super.initState();
    fetchIssuedBooks();
  }

  void fetchIssuedBooks() async {
    List<IssuedBook> books = await IssuedBookRepository.getIssuedBooks();
    setState(() {
      issuedBooks = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.grey,
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Issued Books", style: TextStyle(
            fontWeight: FontWeight.bold,
          ),)),
      body: issuedBooks.isEmpty
          ? Center(child: Text("No books have been issued."))
          : ListView.builder(
        itemCount: issuedBooks.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.indigo[50],
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: ListTile(
              title: Text(issuedBooks[index].bookTitle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Issued to: ${issuedBooks[index].userName}"),
                  //Text("Email: ${issuedBooks[index].email}"),
                  Text("Issue Date: ${issuedBooks[index].issueDate}"),
                  Text("Return Date: ${issuedBooks[index].returnDate}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
