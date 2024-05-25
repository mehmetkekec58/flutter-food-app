import 'package:flutter/material.dart';
import 'package:flutter_food_app/consts/colors.dart';
import 'package:flutter_food_app/modals/category.dart';
import 'package:flutter_food_app/modals/food.dart';
import 'package:flutter_food_app/screens/food_detail_screen.dart';
import 'package:flutter_food_app/services/category_service.dart';
import 'package:flutter_food_app/services/food_service.dart';
import 'package:flutter_food_app/widgets/card_widget.dart';
import 'package:flutter_food_app/widgets/search_widget.dart';
import 'package:toastification/toastification.dart';

class FoodScreen extends StatefulWidget {
  final Category category;

  const FoodScreen({super.key, required this.category});

  @override
  // ignore: library_private_types_in_public_api
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late bool _loading = true;
  final FoodService _foodService = FoodService();
  late List<Food> _foods = [];
  late List<Food> _filteredFoods = [];
  final CategoryService _categoryService = CategoryService();
  late List<Category> _categories = [];
  late Category _category = widget.category;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllFoodsByCategoryName();
    _getAllCategories();
  }

  Future<void> _getAllFoodsByCategoryName() async {
    try {
      final foods =
          await _foodService.getAllFoodsByCategoryName(_category.title);
      setState(() {
        _foods = foods;
        _filteredFoods = foods;
        _loading = false;
      });
    } catch (e) {
        toastification.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: Text('Hata: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> _getAllCategories() async {
    try {
      final categories = await _categoryService.getAllCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      toastification.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: Text('Hata: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
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

  void _onclickFood(Food food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(foodId: food.id),
      ),
    );
  }

  _setCategory(Category category) {
    setState(() {
      _loading = true;
      _category = category;
    });
    _getAllFoodsByCategoryName();
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
            _category.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 30.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => _setCategory(_categories[index]),
                    child: Container(
                      width: 80.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: _categories[index].id == _category.id
                            ? Colors.green
                            : AppColor.lightGreen,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          _categories[index].title,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: _categories[index].id == _category.id
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ));
              },
            ),
          ),
          const SizedBox(height: 15.0),
          _loading
              ? const Center(
                  child: CircularProgressIndicator(), // Yükleniyor animasyonu
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _filteredFoods.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onclickFood(_filteredFoods[index]),
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
