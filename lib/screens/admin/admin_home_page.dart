import 'package:flutter/material.dart';
import 'package:lms/database/user_repo.dart';
import '/widgets/admin_widgets/app_bar.dart';
import '/widgets/admin_widgets/bottom_nav_bar.dart';
import '/widgets/admin_widgets/drawer_menu.dart';
import '/widgets/admin_widgets/dashboard_cards.dart';
import '/widgets/admin_widgets/recent_activities.dart';
import '/widgets/admin_widgets/manage_books_button.dart';
import 'books_screen.dart';
import 'members_screen.dart';
import 'requests_screen.dart';
import 'settings_screen.dart';
import 'package:lms/database/issued_books_repo.dart';
import 'package:lms/database/book_repo.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {


  int totalBooks = 0;
  int totalMembers = 0;
  int booksIssued = 0;
  int pendingReturns = 0;


  int issuedBookCount = 0;
  bool _hasIssuedTestData = false;

  Future<void> initAppData() async {
    await BookRepository.fetchAndStoreBooks();          // ✅ Make sure all books are in DB
    if (!_hasIssuedTestData) {
      _hasIssuedTestData = true;
      await testInsertIssuedBook();       // ✅ Only then issue book// Your custom test insert logic
    }
    await _fetchDashboardStats(); // <-- new function
  }

  Future<void> _fetchDashboardStats() async {
    final books = await BookRepository.getBooks(); // You should already have this
    final members = await UserRepository.getUsers() ; // Adjust as per your user DB
    final issuedBooks = await IssuedBookRepository.getIssuedBooks(); // From your issued_books table
    final now = DateTime.now();

    int overdueCount = issuedBooks.where((book) {
      final returnDate = DateTime.tryParse(book.returnDate);
      //final returnDate = DateTime.tryParse(book['returnDate']);
      return returnDate != null && returnDate.isBefore(now);
    }).length;

    setState(() {
      totalBooks = books.length;
      totalMembers = members.length;
      booksIssued = issuedBooks.length;
      pendingReturns = overdueCount;
    });
  }


  @override
  void initState() {
    super.initState();
   // IssuedBookRepository.removeDuplicateIssuedBooks(); // 👈 Only call once
    initAppData();
    _fetchIssuedBookCount();
    //DBHelper.printIssuedBooks(); // Debugging purpose
  }

  Future<void> _fetchIssuedBookCount() async {
    //int count = await DBHelper.getIssuedBooksCount();
    setState(() {
     // issuedBookCount = count;
    });
  }

  int _selectedIndex = 0;

  /// **Navigation Handler**
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 15),
          DashboardCards(
            totalBooks: totalBooks,
            totalMembers: totalMembers,
            booksIssued: booksIssued,
            pendingReturns: pendingReturns,
          ),

            SizedBox(height: 20),
            RecentActivities(),
            SizedBox(height: 20),
            //PendingRequests(),
            SizedBox(height: 20),
            ManageBooksButton(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      drawer: DrawerMenu(),

    );
  }

/// **Admin Home & Log Out Section**

  Widget _buildHeader() {
    return Container(
      child:
        Text("ADMIN HOME PAGE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

    );
  }
}
