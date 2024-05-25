import 'package:flutter/material.dart';
import 'package:flutter_food_app/modals/category.dart';
import 'package:flutter_food_app/screens/food_screen.dart';
import 'package:flutter_food_app/services/category_service.dart';
import 'package:flutter_food_app/widgets/card_widget.dart';
import 'package:flutter_food_app/widgets/search_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Food App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CategoryService _categoryService = CategoryService();

  late List<Category> _categories = [];
  late List<Category> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllCategories();
  }

  Future<void> _getAllCategories() async {
    try {
      final categories = await _categoryService.getAllCategories();
      setState(() {
        _categories = categories;
        _filteredCategories = categories;
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  void _search(query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories.toList();
        return;
      }
      _filteredCategories = _categories
          .where((category) =>
              category.description.toLowerCase().contains(query.toLowerCase()) ||
              category.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onclickCategory(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SearchWidget(
            searchController: _searchController,
            onChanged: _search,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onclickCategory(_filteredCategories[index]),
                  child: CardWidget(
                    id: _filteredCategories[index].id,
                    title: _filteredCategories[index].title,
                    description: _filteredCategories[index].description,
                    imagePath: _filteredCategories[index].thumb,
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
