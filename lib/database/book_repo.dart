import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class BookRepository {
  static Future<void> fetchAndStoreBooks() async {
    Database db = await DBHelper.initDB();
    String url = "https://www.freetestapi.com/api/v1/books";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("✅ Books fetched from API!");
      List<dynamic> books = json.decode(response.body);

      for (var book in books) {
        await db.insert("books", {
          "id": book["id"],
          "title": book["title"],
          "author": book["author"],
          "publicationYear": book["publication_year"],
          "genre": jsonEncode(book["genre"]), // Store array as JSON string
          "description": book["description"],
          "coverImage": book["cover_image"],
          "totalCopies": 5,
          "availableCopies": 5,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
        print("✅ Inserted book: ${book["title"]} (ID: ${book["id"]})");
      }
    }
  }
  // In DBHelper or BookRepository
  static Future<List<Map<String, dynamic>>> getBooks() async {
    final Database db = await DBHelper.initDB();
    final List<Map<String, dynamic>> books = await db.query('books');
    return books;
  }



}
