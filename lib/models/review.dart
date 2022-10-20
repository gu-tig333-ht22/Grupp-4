class Review {
  final String id;
  final String author;
  final String content;
  final String createdAt;

  Review({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt
  });

  factory Review.fromJson(Map<String, dynamic> fromJson) {
    return Review(
      id: fromJson["id"], 
      author: fromJson["author"], 
      content: fromJson["content"], 
      createdAt: fromJson["created_at"]);
  }
}