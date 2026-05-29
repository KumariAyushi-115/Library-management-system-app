import 'package:flutter/material.dart';

class PendingRequests extends StatelessWidget {
  final List<Map<String, String>> requests = [
    {"name": "Alice Johnson", "book": "To Kill a Mockingbird"},
    {"name": "Mark Spencer", "book": "1984"},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pending Requests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.pending_actions, color: Colors.orange),
                  title: Text("${requests[index]["name"]} requested '${requests[index]["book"]}'"),
                  trailing: Wrap(
                    spacing: 10,
                    children: [
                      IconButton(icon: Icon(Icons.check, color: Colors.green), onPressed: () {}),
                      IconButton(icon: Icon(Icons.close, color: Colors.red), onPressed: () {}),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
