import 'package:flutter/material.dart';
import 'package:flutter_food_app/consts/messages.dart';
import 'package:flutter_food_app/modals/food_detail.dart';
import 'package:flutter_food_app/services/food_service.dart';
import 'package:toastification/toastification.dart';

class FoodDetailScreen extends StatefulWidget {
  final String foodId;
  const FoodDetailScreen({super.key, required this.foodId});

  @override
  // ignore: library_private_types_in_public_api
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final FoodService _foodService = FoodService();
  late FoodDetail? _foodDetail = null;

  @override
  void initState() {
    super.initState();
    _getFoodDetailByFoodId();
  }

  Future<void> _getFoodDetailByFoodId() async {
    try {
      print(widget.foodId);
      final foodDetail =
          await _foodService.getFoodDetailByFoodId(widget.foodId);
      setState(() {
        _foodDetail = foodDetail;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Food App'),
      ),
      body: _foodDetail == null
          ? const Center(
              child: CircularProgressIndicator(), // Yükleniyor animasyonu
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: _foodDetail!.thumb,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    _foodDetail!.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _foodDetail!.description,
                      style: const TextStyle(fontSize: 13.0),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      Messages.ingredients,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        _foodDetail!.ingredients.length,
                        (index) {
                          final ingredient = _foodDetail!.ingredients[index];
                          final measure = _foodDetail!.measures[index];
                          if (ingredient != "" &&
                              ingredient != null &&
                              measure != null &&
                              measure != "") {
                            return Text(
                                '${index + 1}) $ingredient: ($measure)');
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.black, // Çizginin rengi
                      thickness: 0.5, // Çizginin kalınlığı
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "${Messages.area}: ${_foodDetail!.country}",
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "${Messages.caregory}: ${_foodDetail!.category}",
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
    );
  }
}
