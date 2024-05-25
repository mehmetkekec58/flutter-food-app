import 'dart:convert';
import 'package:flutter_food_app/consts/base_url.dart';
import 'package:flutter_food_app/modals/food.dart';
import 'package:http/http.dart' as http;

class FoodService {
  Future<List<Food>> getAllFoodsByCategoryName(String categoryName) async {
    final response =
        await http.get(Uri.parse("${BaseUrl.url}filter.php?c=$categoryName"));
    if (response.statusCode == 200) {
      final List<dynamic> foodsJson = json.decode(response.body)['meals'];
      return foodsJson.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception('Kategorideki yemekler yüklenmedi');
    }
  }
}
