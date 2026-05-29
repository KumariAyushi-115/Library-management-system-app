import 'package:flutter/material.dart';
import '/screens/admin/books_screen.dart';
import 'package:lms/screens/admin/issued_books_screen.dart';
import '/screens/admin/members_screen.dart';
import '/screens/admin/pending_return_screen.dart';


class DashboardCards extends StatelessWidget {
  final int totalBooks;
  final int totalMembers;
  final int booksIssued;
  final int pendingReturns;

  DashboardCards({
    required this.totalBooks,
    required this.totalMembers,
    required this.booksIssued,
    required this.pendingReturns,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stats = [
      {
        "icon": Icons.menu_book,
        "label": "Total Books",
        "count": totalBooks,
        "route": BooksScreen()
      },
      {
        "icon": Icons.people,
        "label": "Total Members",
        "count": totalMembers,
        "route": MembersScreen()
      },
      {
        "icon": Icons.book_online,
        "label": "Books Issued",
        "count": booksIssued,
        "route": IssuedBooksScreen()
      },
      {
        "icon": Icons.schedule,
        "label": "Pending Returns",
        "count": pendingReturns,
        "route": PendingReturnScreen()
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => stats[index]["route"]),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(stats[index]["icon"], size: 28, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    stats[index]["label"],
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    stats[index]["count"].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

