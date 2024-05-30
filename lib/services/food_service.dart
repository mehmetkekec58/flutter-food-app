import 'dart:convert';
import 'package:flutter_food_app/consts/base_url.dart';
import 'package:flutter_food_app/modals/food.dart';
import 'package:flutter_food_app/modals/food_detail.dart';
import 'package:http/http.dart' as http;

class FoodService {
  // Kategori adına göre tüm yiyecekleri listeler
  Future<List<Food>> getAllFoodsByCategoryName(String categoryName) async {
    final response =
        await http.get(Uri.parse("${BaseUrl.url}filter.php?c=$categoryName"));
    if (response.statusCode == 200) {
      final List<dynamic> foodsJson = json.decode(response.body)['meals'];
      return foodsJson.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception('Kategorideki yemekler yüklenemedi');
    }
  }

   // yiyecek Id ye göre yiyecek detaylarını getirir
   Future<FoodDetail?> getFoodDetailByFoodId(String foodId) async {
    final response =
        await http.get(Uri.parse("${BaseUrl.url}lookup.php?i=$foodId"));
    if (response.statusCode == 200) {
      final List<dynamic> foodsJson = json.decode(response.body)['meals'];
      print(foodsJson);
      return foodsJson.map((json) => FoodDetail.fromJson(json)).toList().firstOrNull;
    } else {
      throw Exception('Yemek yüklenemedi');
    }
  }
}
