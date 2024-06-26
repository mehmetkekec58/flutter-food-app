import 'dart:convert';
import 'package:flutter_food_app/consts/base_url.dart';
import 'package:flutter_food_app/modals/category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  // Tüm kategorileri listeler
  Future<List<Category>> getAllCategories() async {
    final response = await http.get(Uri.parse('${BaseUrl.url}categories.php'));
    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson =
          json.decode(response.body)['categories'];
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Kategoriler yüklenmedi');
    }
  }
}
