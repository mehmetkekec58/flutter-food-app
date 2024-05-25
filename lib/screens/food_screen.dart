import 'package:flutter/material.dart';
import 'package:flutter_food_app/modals/category.dart';
import 'package:flutter_food_app/modals/food.dart';
import 'package:flutter_food_app/screens/food_detail_screen.dart';
import 'package:flutter_food_app/services/food_service.dart';
import 'package:flutter_food_app/widgets/card_widget.dart';
import 'package:flutter_food_app/widgets/search_widget.dart';

class FoodScreen extends StatefulWidget {
  final Category category;

  const FoodScreen({super.key, required this.category});

  @override
  // ignore: library_private_types_in_public_api
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodService _foodService = FoodService();
  late List<Food> _foods = [];
  late List<Food> _filteredFoods = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllFoodsByCategoryName();
  }

  Future<void> _getAllFoodsByCategoryName() async {
    try {
      print(widget.category.title);
      final foods =
          await _foodService.getAllFoodsByCategoryName(widget.category.title);
      setState(() {
        _foods = foods;
        _filteredFoods = foods;
      });
    } catch (e) {
      print('Hata var: $e');
    }
  }

  void _search(query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFoods = _foods.toList();
        return;
      }
      _filteredFoods = _foods
          .where(
              (food) => food.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onclickCategory(Food food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(foodId: food.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Food App'),
      ),
      body: Column(
        children: [
          SearchWidget(
            searchController: _searchController,
            onChanged: _search,
          ),
          Text(
            "${widget.category.title} Kategorisi",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredFoods.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onclickCategory(_filteredFoods[index]),
                  child: CardWidget(
                    id: _filteredFoods[index].id,
                    title: _filteredFoods[index].title,
                    description: "",
                    imagePath: _filteredFoods[index].thumb,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
