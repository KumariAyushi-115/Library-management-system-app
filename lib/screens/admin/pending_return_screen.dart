import 'package:flutter/material.dart';
import 'package:lms/database/issued_books_repo.dart';

class PendingReturnScreen extends StatefulWidget {
  @override
  _PendingReturnScreenState createState() => _PendingReturnScreenState();
}

class _PendingReturnScreenState extends State<PendingReturnScreen> {
  List<Map<String, dynamic>> pendingReturns = [];

  @override
  void initState() {
    super.initState();
    _fetchPendingReturns();
  }

  Future<void> _fetchPendingReturns() async {
    final data = await IssuedBookRepository.getPendingReturns();
    setState(() {
      pendingReturns = data;
    });
  }

  int _calculateOverdueDays(String returnDate) {
    final returnDt = DateTime.parse(returnDate);
    final today = DateTime.now();
    return today.difference(returnDt).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
          title: Text("Pending Returns",style: TextStyle(fontWeight: FontWeight.bold),)
      ),
      body: pendingReturns.isEmpty
          ? Center(child: Text("No pending returns!", style: TextStyle(fontSize: 18)))
          : ListView.builder(
        itemCount: pendingReturns.length,
        itemBuilder: (context, index) {
          final entry = pendingReturns[index];
          final overdueDays = _calculateOverdueDays(entry['returnDate']);

          return Card(
            //color: Colors.orange[50],
            margin: EdgeInsets.all(10),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.book, color: Colors.blue),
              title: Text(entry['bookTitle'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 6),
                      Expanded(child: Text("${entry['userName']}")),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 18),
                      SizedBox(width: 6),
                      Expanded(child: Text("${entry['email']}")),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range, size: 18),
                      SizedBox(width: 6),
                      Text("Issued: ${entry['issueDate']}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.assignment_return, size: 18),
                      SizedBox(width: 6),
                      Text("Return: ${entry['returnDate']}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red, size: 18),
                      SizedBox(width: 6),
                      Text("Overdue by $overdueDays days",
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
