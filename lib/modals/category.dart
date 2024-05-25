class Category {
  final String id;
  final String title;
  final String thumb;
  final String description;

  Category({
    required this.id,
    required this.title,
    required this.thumb,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      title: json['strCategory'],
      thumb: json['strCategoryThumb'],
      description: json['strCategoryDescription'],
    );
  }
}