import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:lms/models/dashboard_stats.dart';

class DBHelper {
  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'library.db');

    print("Database Path: $path");

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS books");
        await db.execute("DROP TABLE IF EXISTS users");
        await db.execute("DROP TABLE IF EXISTS issued_books");
        await _onCreate(db, newVersion);
      },
    );
  }

  // ✅ Define the _onCreate function properly here
  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        userId INTEGER PRIMARY KEY,
        userName TEXT,
        email TEXT,
        contact TEXT,
        address TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY,
        title TEXT,
        author TEXT,
        publicationYear INTEGER,
        genre TEXT,
        description TEXT,
        coverImage TEXT,
        totalCopies INTEGER DEFAULT 5,
        availableCopies INTEGER DEFAULT 5
      )
    ''');

    await db.execute('''
      CREATE TABLE issued_books (
        issueId INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        id INTEGER,
        bookTitle TEXT,
        issueDate TEXT,
        returnDate TEXT,
        FOREIGN KEY (userId) REFERENCES users(userId),
        FOREIGN KEY (id) REFERENCES books(id)
      )
    ''');

    print("✅ Database and tables created successfully.");
  }


  //------------------------------------------------------------------------------


  //------------------------------------------------------------------------------
   //dashboard stats

  static Future<DashboardStats> getDashboardStats() async {
    final db = await initDB();

    final totalBooks = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM books')
    ) ?? 0;

    final totalMembers = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM users')
    ) ?? 0;

    final booksIssued = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM issued_books')
    ) ?? 0;

    final pendingReturns = Sqflite.firstIntValue(
        await db.rawQuery('''
      SELECT COUNT(*) FROM issued_books 
      WHERE DATE(returnDate) < DATE('now')
    ''')
    ) ?? 0;

    return DashboardStats(
      totalBooks: totalBooks,
      totalMembers: totalMembers,
      booksIssued: booksIssued,
      pendingReturns: pendingReturns,
    );
  }


  //----------------------------------------------------------------------------------
}
