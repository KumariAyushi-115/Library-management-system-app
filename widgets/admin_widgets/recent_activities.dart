import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  final List<String> activities = [
    "'Harry Potter' issued by John Doe - 2 days ago",
    "'The Great Gatsby' returned by Sarah Lee - 1 day ago",
    "'Moby Dick' issued by Adam Smith - 4 days ago",
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      //color: Colors.indigo[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Book Activities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                Icon activityIcon;

                if (activities[index].contains("issued")) {
                  activityIcon = Icon(Icons.menu_book, color: Colors.green[300]);
                } else if (activities[index].contains("returned")) {
                  activityIcon = Icon(Icons.assignment_return, color: Colors.amber);
                } else {
                  activityIcon = Icon(Icons.info_outline, color: Colors.blue);
                }

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        activityIcon,
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            activities[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
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
