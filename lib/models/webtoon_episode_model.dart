class WebtoonEpisodeModel {
  final String id, title, rating, date;

  const WebtoonEpisodeModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.date,
  });

  factory WebtoonEpisodeModel.fromJson(Map<String, dynamic> json) {
    return WebtoonEpisodeModel(
      id: json['id'],
      title: json['title'],
      rating: json['rating'],
      date: json['date'],
    );
  }

  @override
  String toString() {
    return 'WebtoonEpisodeModel{id: $id, title: $title, rating: $rating, date: $date}';
  }
}
