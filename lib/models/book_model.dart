class Book {
  final int id;
  final String title;
  final String author;
  final int publicationYear;
  final List<String> genre;
  final String description;
  //final String coverImage;
  int totalCopies;
  int availableCopies;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.publicationYear,
    required this.genre,
    required this.description,
    //required this.coverImage,
    this.totalCopies = 5, // Default value
    this.availableCopies = 5, // Default value
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      publicationYear: json['publication_year'],
      genre: List<String>.from(json['genre']),
      description: json['description'],
      //coverImage: json['cover_image'],
    );
  }
}
