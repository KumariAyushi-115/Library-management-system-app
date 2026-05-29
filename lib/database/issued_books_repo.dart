import "package:lms/models/issued_book.dart";
import '/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class IssuedBookRepository {
  // Function to fetch issued books with user data
  static Future<List<IssuedBook>> getIssuedBooks() async {
    Database db = await DBHelper.initDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT issued_books.issueId, issued_books.userId, users.userName, issued_books.id,
             issued_books.bookTitle, issued_books.issueDate, issued_books.returnDate
      FROM issued_books 
      JOIN users ON issued_books.userId = users.userId
      JOIN books ON issued_books.id = books.id
    ''');

    return List.generate(maps.length, (i) {
      return IssuedBook(
        issueId: maps[i]['issueId'],
        userId: maps[i]['userId'],
        userName: maps[i]['userName'],
        id :maps[i]['id'],
        bookTitle: maps[i]['bookTitle'],
        issueDate: maps[i]['issueDate'],
        returnDate: maps[i]['returnDate'],
      );
    });
  }

  //  Function to issue a book and update availableCopies
  static Future<void> issueBook({
    required int userId,
    required String userName,
    //required String email,
    required int id,
    required String bookTitle,
    required String issueDate,
    required String returnDate,
  }) async {
    Database db = await DBHelper.initDB();

    // Check available copies


    final bookResult = await db.query("books", where: "id = ?", whereArgs: [id]);
    if (bookResult.isEmpty) {
      throw Exception("Book not found in database.");
    }

    int availableCopies = (bookResult.first["availableCopies"] ?? 0) as int;

    if (availableCopies <= 0) {
      throw Exception(" No available copies left to issue.");
    }


    //--------------------------------------------------------------------------
    //  Check if the record already exists
    List<Map<String, dynamic>> existing = await db.query(
      "issued_books",
      where: "userId = ? AND id = ? AND issueDate = ?",
      whereArgs: [userId, id, issueDate],
    );
    if (existing.isNotEmpty) {
      print(" Book already issued for this user on this date.");
      return; //  Skip insertion
    }

    //---------------------------------------------------------------------------




    // Insert issued book
    await db.insert("issued_books", {
      "userId": userId,
      "id": id,
      "bookTitle": bookTitle,
      "issueDate": issueDate,
      "returnDate": returnDate,
    });

    // Decrease availableCopies by 1
    await db.rawUpdate('''
      UPDATE books 
      SET availableCopies = availableCopies - 1 
      WHERE id = ?
    ''', [id]);

    print(" Book issued successfully!");
  }

  static Future<List<Map<String, dynamic>>> getIssuedBooksForUser(int userId) async {
    final db = await DBHelper.initDB();
    return await db.query(
      'issued_books',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
 //------------------------------------------------------------------------------

  static Future<List<Map<String, dynamic>>> getPendingReturns() async {
    final db = await DBHelper.initDB();
    final now = DateTime.now().toIso8601String().substring(0, 10); // yyyy-MM-dd

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      ib.issueId, ib.userId, u.userName, u.email,
      ib.bookTitle, ib.issueDate, ib.returnDate
    FROM issued_books ib
    JOIN users u ON ib.userId = u.userId
    WHERE DATE(ib.returnDate) < DATE(?)
  ''', [now]);

    return result;
  }


  //-----------------------------------------------------------------------------
  static Future<List<IssuedBook>> getIssuedBooksByUser(int userId) async {
    Database db = await DBHelper.initDB();

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT issued_books.issueId, issued_books.userId, users.userName, issued_books.id,
           issued_books.bookTitle, issued_books.issueDate, issued_books.returnDate
    FROM issued_books 
    JOIN users ON issued_books.userId = users.userId
    JOIN books ON issued_books.id = books.id
    WHERE issued_books.userId = ?
  ''', [userId]);

    return List.generate(maps.length, (i) {
      return IssuedBook(
        issueId: maps[i]['issueId'],
        userId: maps[i]['userId'],
        id: maps[i]['id'],
        userName: maps[i]['userName'],        //  Add this line
        bookTitle: maps[i]['bookTitle'],
        issueDate: maps[i]['issueDate'],
        returnDate: maps[i]['returnDate'],
      );
    });
  }


  //-----------------------------------------------------------------------------
  static Future<void> removeDuplicateIssuedBooks() async {
    final db = await DBHelper.initDB();

    await db.execute('''
    DELETE FROM issued_books
    WHERE issueId NOT IN (
      SELECT MIN(issueId)
      FROM issued_books
      GROUP BY userId, id, issueDate
    )
  ''');

    print(" Duplicate issued books removed!");

    //---------------------------------------------------------------------------------
  }

}

Future<void> testInsertIssuedBook() async {
  await IssuedBookRepository.issueBook(
    userId: 1,
    userName: 'Mr. Ryan Terry',
    id: 1,
    bookTitle: 'To Kill a Mockingbird',
    issueDate: '2025-04-01',
    returnDate: '2025-04-15',
  );

  await IssuedBookRepository.issueBook(
    userId: 10,
    userName: 'Deborah Bell',
    id: 2,
    bookTitle: '1984',
    issueDate: '2025-03-28',
    returnDate: '2025-04-10',
  );

  await IssuedBookRepository.issueBook(
    userId: 40,
    userName: 'John Castaneda',
    id: 30,
    bookTitle: 'Fahrenheit 451',
    issueDate: '2025-03-20',
    returnDate: '2025-03-30',
  );

  await IssuedBookRepository.issueBook(
    userId: 1,
    userName: 'Mr. Ryan Terry',
    id: 48,
    bookTitle: 'The Stand',
    issueDate: '2025-03-15',
    returnDate: '2025-03-25',
  );
}
