import 'package:flutter/material.dart';
import '/models/issued_book.dart';
import 'package:lms/database/issued_books_repo.dart';

class UserDetailScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  UserDetailScreen({required this.userData});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  List<IssuedBook> issuedBooks = [];

  @override
  void initState() {
    super.initState();

    _fetchIssuedBooks();
  }

  Future<void> _fetchIssuedBooks() async {
    List<IssuedBook> books = await IssuedBookRepository.getIssuedBooksByUser(
        widget.userData['userId']);
    setState(() {
      issuedBooks.clear(); // Avoid duplicates
      issuedBooks = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text(
          widget.userData['userName'],
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // User Details
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo[400],
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.userData['userName'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),

                  /// EMAIL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.email, size: 16),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          widget.userData['email'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  /// CONTACT
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.phone, size: 16),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          widget.userData['contact'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  /// ADDRESS
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.home, size: 16),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          widget.userData['address'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Issued Books Section
            Expanded(
              child: issuedBooks.isEmpty
                  ? Center(
                child: Text(
                  "No books issued",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: issuedBooks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ListTile(
                      leading: Icon(Icons.book, color:Colors.indigo[400], ),
                      title: Text(
                        issuedBooks[index].bookTitle,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16),
                              SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                    "Issued: ${issuedBooks[index].issueDate}"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.update, size: 16),
                              SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                    "Return: ${issuedBooks[index].returnDate}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


