import 'package:flutter_food_app/modals/food.dart';

class FoodDetail extends Food {
  String description;
  String category;
  String country;
  String youtubeVideo;
  List<String?> ingredients;
  List<String?> measures;

  FoodDetail({
    required id,
    required title,
    required thumb,
    required this.description,
    required this.category,
    required this.country,
    required this.youtubeVideo,
    required this.ingredients,
    required this.measures,
  }) : super(id: id, title: title, thumb: thumb);

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    return FoodDetail(
      id: json['idMeal'],
      title: json['strMeal'],
      thumb: json['strMealThumb'],
      description: json['strInstructions'],
      category: json['strCategory'],
      country: json['strArea'],
      youtubeVideo: json['strYoutube'],
      ingredients: List<String>.generate(20, (index) => json['strIngredient${index + 1}']),
      measures: List<String>.generate(20, (index) => json['strMeasure${index + 1}']),
    );
  }
}
