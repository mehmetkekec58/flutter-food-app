import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;
  final String searchText;

  const SearchWidget(
      {super.key, required this.searchController, required this.onSearch, this.searchText = "Ara..."});

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
              decoration: InputDecoration(
                hintText: searchText,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
