import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:muztunes/common/cutom_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Ionicons.arrow_back)),
              const SizedBox(width: 3),
              Expanded(
                child: CustomTextField(
                  onTap: () {
                    FocusScope.of(context).requestFocus();
                  },
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  hintText: "Search For Foods",
                  onChanged: (value) {},
                  suffixIcon: _searchController.text.isEmpty
                      ? GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Ionicons.search_circle,
                            size: 40,
                            color: Color(0xff83829A),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (_searchController.text.isNotEmpty) {
                              _searchController.clear();
                              FocusScope.of(context).unfocus();
                            }
                          },
                          child: const Icon(
                            Ionicons.close_circle,
                            size: 40,
                            color: Color(0xff83829A),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        body: const SafeArea(child: SizedBox()));
  }
}
