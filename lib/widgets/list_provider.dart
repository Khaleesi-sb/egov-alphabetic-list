import 'package:flutter/cupertino.dart';

import '../country_list.dart';

class CountryListProvider extends ChangeNotifier{

  List<CountryList> items = [];
  List<CountryList> filteredItems = [];
  List<CountryList> selectedItems = [];
  TextEditingController searchController = TextEditingController();

  void initList(List<Map<String, String>> items) {
    this.items = items.map((item) {
      String country = item['country'] ?? '';
      String city = item['city'] ?? '';
      String image = item['image'] ?? '';
      String tag = country.isNotEmpty ? country[0] : '';
      return CountryList(
        country: country,
        city: city,
        image: image,
        tag: tag,
      );
    }).toList();
    filteredItems.addAll(this.items);
  }

  void filterList(String query) {
    // setState(() {
      filteredItems = items
          .where((item) =>
      item.country.toLowerCase().contains(query.toLowerCase()) ||
          item.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners(); // Notify listeners after filtering items
    // });
  }

  void toggleItemSelection(CountryList item) {
    // setState(() {
      item.isSelected = !item.isSelected;
      if (item.isSelected) {
        selectedItems.add(item);
        filteredItems
            .removeWhere((selected) => selected.country == item.country);
      } else {
        selectedItems
            .removeWhere((selected) => selected.country == item.country);
        filteredItems.add(item);
      }
      selectedItems.sort((a, b) => a.country.compareTo(b.country));
      filteredItems.sort((a, b) => a.country.compareTo(b.country));
      for (var filteredItem in filteredItems) {
        if (filteredItem.country == item.country) {
          filteredItem.isSelected = item.isSelected;
        }
      }
      notifyListeners(); // Notify listeners after filtering items
    // });
  }

  void clearAll(){
    selectedItems.clear();
    for (var filteredItem in filteredItems) {
      filteredItem.isSelected = false;
    }
    notifyListeners();
  }

}