import 'package:flutter/material.dart';
import 'package:flutter_food_app/consts/messages.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback? onSearch;
  final ValueChanged<String>? onChanged;
  final String searchText;

  const SearchWidget(
      {super.key,
      required this.searchController,
      this.onSearch,
      this.onChanged,
      this.searchText = Messages.search});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: searchText,
                border: InputBorder.none,
              ),
            ),
          ),
          if (searchController.text != "")
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onSearch,
            ),
          if (onSearch != null)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: onSearch,
            ),
        ],
      ),
    );
  }
}