import 'package:flutter/material.dart';
import 'package:flutter_food_app/modals/category.dart';

class FoodScreen extends StatelessWidget {
  final Category category;

  const FoodScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Food App')),
      body: Center(
        child: Text(category.title),
      ),
    );
  }
}
