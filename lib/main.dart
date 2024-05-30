import 'package:flutter/material.dart';
import 'package:flutter_food_app/modals/category.dart';
import 'package:flutter_food_app/screens/food_screen.dart';
import 'package:flutter_food_app/services/category_service.dart';
import 'package:flutter_food_app/widgets/card_widget.dart';
import 'package:flutter_food_app/widgets/search_widget.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
        child: MaterialApp(
      title: 'Flutter Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Food App'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // kategori servisi çağırdım
  final CategoryService _categoryService = CategoryService();

  late List<Category> _categories = [];
  // filtered kategoriyi liste ile ekrana basıyorum.
  late List<Category> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // sayfa açılırken bu fonksiyonu çalıştırıyorum.
    _getAllCategories();
  }

// async işlem ile API'ye istek atıyorum
  Future<void> _getAllCategories() async {
    try {
      final categories = await _categoryService.getAllCategories();
      setState(() {
        _categories = categories;
        _filteredCategories = categories;
      });
    } catch (e) {
      // hata alırsa bildirim gönderiyorum
      toastification.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: Text('Hata: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

// onChange a _search fonksiyonunu atadım ve query de search widget a ne yazıldıysa onu veriyor. Eğer query'nin içi boşaltıldıysa tüm kategorileri tekrardan listelemek
// için filtered category ye category ı atıyorum.
// eğer query doluysa lowercase yapıp açıklamada ya da başlıkla bu queryi içeren kategorileri fileted category e atıyorum.
  void _search(query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories.toList();
        return;
      }
      _filteredCategories = _categories
          .where((category) =>
              category.description
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              category.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

// category e tıklanınca kategorinin yemeklerini listelemek için FoodScreen a gidiyor ve veri olarak category i gönderiyor.

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
          // Dinamik olarak yazdığım ara inputum
          SearchWidget(
            searchController: _searchController,
            onChanged: _search,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCategories.length,
              itemBuilder: (context, index) {
                // GestureDetector onTap ile listeye tıklamayı sağlıyor.
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
