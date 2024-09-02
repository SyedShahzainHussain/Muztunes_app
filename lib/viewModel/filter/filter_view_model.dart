import 'package:flutter/material.dart';

class FilterViewModel with ChangeNotifier {
  // Filter state
  double _minPrice = 0.0;
  double _maxPrice = 10000.0;

  // Only one category can be selected at a time
  String _selectedCategory = '';

  // Sorting state
  String _sortOption = 'Lowest To Highest Price';

  // Getters
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  String get selectedCategory => _selectedCategory;
  String get sortOption => _sortOption;

  // Setters
  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSortOption(String option) {
    _sortOption = option;
    notifyListeners();
  }

  void clear() {
    _selectedCategory = '';
    _minPrice = 0.0;
    _maxPrice = 10000.0;
    saveCategory = "";
    saveminPrice = 0.0;
    savemaxPrice = 0.0;

    notifyListeners();
  }

  String saveCategory = '';
  double saveminPrice = 0.0;
  double savemaxPrice = 0.0;

  void save() {
    saveCategory = _selectedCategory;
    saveminPrice = _minPrice;
    savemaxPrice = _maxPrice;
    notifyListeners();
  }
}
