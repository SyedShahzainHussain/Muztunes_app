import 'package:flutter/material.dart';
import 'package:muztune/config/colors.dart';
import 'package:muztune/viewModel/filter/filter_view_model.dart';
import 'package:provider/provider.dart';

class SortByScreen extends StatelessWidget {
  const SortByScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Sort by",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          _buildSortOption(context, "Popular"),
          _buildSortOption(context, "Newest"),
          _buildSortOption(context, "Lowest To Highest Price"),
          _buildSortOption(context, "Highest To Lowest Price"),
        ],
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, String option) {
    final filterProvider = Provider.of<FilterViewModel>(context);
    final isSelected = filterProvider.sortOption == option;

    return GestureDetector(
      onTap: () {
        filterProvider.setSortOption(option);
        Navigator.pop(context);
      },
      child: Container(
        color: isSelected ? AppColors.redColor : Colors.transparent,
        child: ListTile(
          title: Text(option),
        ),
      ),
    );
  }
}
