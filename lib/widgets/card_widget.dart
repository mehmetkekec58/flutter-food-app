import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_food_app/consts/colors.dart';

class CardWidget extends StatelessWidget {
  final String id;
  final String imagePath;
  final String title;
  final String description;

  const CardWidget({
    super.key,
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    int textLength = 150;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColor.lightGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image:imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                description.length > textLength
                    ? "${description.substring(0, textLength)}..."
                    : description,
                style: const TextStyle(color: AppColor.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
