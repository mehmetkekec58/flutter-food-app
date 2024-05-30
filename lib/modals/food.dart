class Food {
  final String id;
  final String title;
  final String thumb;

  Food({
    required this.id,
    required this.title,
    required this.thumb,
  });
// API'den json olarak gelen veriyi kendi modelime mapladim
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['idMeal'],
      title: json['strMeal'],
      thumb: json['strMealThumb'],
    );
  }
}