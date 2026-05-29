import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static List<dynamic>? _cachedBooks; // Cache to avoid multiple fetches

  static Future<List<dynamic>> fetchBooks() async {
    if (_cachedBooks != null) {
      return _cachedBooks!; // Return cached books to reduce network calls
    }

    final url = "https://www.freetestapi.com/api/v1/books";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _cachedBooks = json.decode(response.body);
        return _cachedBooks!;
      } else {
        throw Exception("Failed to load books");
      }
    } catch (e) {
      throw Exception("Error fetching books: $e");
    }
  }
}

