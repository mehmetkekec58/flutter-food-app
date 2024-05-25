import 'package:flutter/material.dart';
import 'package:flutter_food_app/modals/category.dart';
import 'package:flutter_food_app/widgets/category_card_widget.dart';
import 'package:flutter_food_app/widgets/search_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
  final List<Category> items = List<Category>.generate(100, (i) => Category(
    idCategory: i.toString(),
    strCategory: "$i category",
    strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
    strCategoryDescription: "Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011. Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.",
  ));
  final TextEditingController _searchController = TextEditingController();

  void _search() {
    String query = _searchController.text;
    // Burada arama sorgusunu kullanarak istediğiniz işlemi yapabilirsiniz
    print("Arama sorgusu: $query");
    // Örneğin, arama sorgusuyla bir API çağrısı yapabilirsiniz
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
            onSearch: _search,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CategoryCardWidget(
                  title: items[index].strCategory,
                  description: items[index].strCategoryDescription,
                  imagePath:items[index].strCategoryThumb,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
