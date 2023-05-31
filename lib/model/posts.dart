class Posts {
  final int id;
  final String title;
  final String body;

  Posts(this.id, this.title, this.body);

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      json['id'],
      json['title'],
      json['body'],
    );
  }
}
