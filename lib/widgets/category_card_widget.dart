import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const CategoryCardWidget({
    super.key,
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
        color: const Color.fromRGBO(0, 0, 0, 0.498),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        elevation: 4,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              imagePath,
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
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                description.length > textLength
                    ? "${description.substring(0, textLength)}..."
                    : description,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
