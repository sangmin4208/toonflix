class Webtoon {
  final String title;
  final String thumb;
  final String id;

  Webtoon({
    required this.title,
    required this.thumb,
    required this.id,
  });

  factory Webtoon.fromJson(Map<String, dynamic> json) {
    return Webtoon(
      title: json['title'],
      thumb: json['thumb'],
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'Webtoon{title: $title, thumb: $thumb, id: $id}';
  }
}
