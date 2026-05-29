class IssuedBook {
  final int issueId;
  final int userId;
  final String userName;
  final int id;
  final String bookTitle;
  final String issueDate;
  final String returnDate;

  IssuedBook({
    required this.issueId,
    required this.userId,
    required this.userName,
    required this.id,
    required this.bookTitle,
    required this.issueDate,
    required this.returnDate,
  });

  factory IssuedBook.fromJson(Map<String, dynamic> json) {
    return IssuedBook(
      issueId: json['issueId'],
      userId: json['userId'],
      userName: json['userName'],
      id: json['id'],
      bookTitle: json['bookTitle'],
      issueDate: json['issueDate'],
      returnDate: json['returnDate'],
    );
  }
}
