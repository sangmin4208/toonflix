class WebtoonDetailModel {
  const WebtoonDetailModel({
    required this.title,
    required this.about,
    required this.genre,
    required this.age,
  });
  final String title, about, genre, age;

  factory WebtoonDetailModel.fromJson(Map<String, dynamic> json) {
    return WebtoonDetailModel(
      title: json['title'],
      about: json['about'],
      genre: json['genre'],
      age: json['age'],
    );
  }

  @override
  String toString() {
    return 'WebtoonDetailModel{title: $title, about: $about, genre: $genre, age: $age}';
  }
}
