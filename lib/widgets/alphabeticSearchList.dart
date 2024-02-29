import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import '../country_list.dart';

class AlphabetScroll extends StatefulWidget {
  final List<Map<String, String>> items;

  const AlphabetScroll({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<AlphabetScroll> createState() => _AlphabetScrollState();
}

class _AlphabetScrollState extends State<AlphabetScroll> {
  List<CountryList> items = [];
  List<CountryList> filteredItems = [];
  List<CountryList> selectedItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initList(widget.items);
  }

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
    setState(() {
      filteredItems = items
          .where((item) =>
          item.country.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleItemSelection(CountryList item) {
    setState(() {
      item.isSelected = !item.isSelected;
      if (item.isSelected) {
        selectedItems.add(item);
      } else {
        selectedItems.removeWhere((selected) => selected.country == item.country);
      }
      selectedItems.sort((a, b) => a.country.compareTo(b.country));
      for (var filteredItem in filteredItems) {
        if (filteredItem.country == item.country) {
          filteredItem.isSelected = item.isSelected;
        }
      }
    });
  }

  bool isMinimised = false;
  bool isRotated = false;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        RotatedBox(
          quarterTurns: isRotated ? 3 : 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Locations",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isMinimised = !isMinimised;
                        });
                      },
                      icon: !isMinimised ? const Icon(Icons.minimize) : const Icon(Icons.home_max),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isRotated = !isRotated;
                          if(isRotated){
                            isMinimised = true;
                          }
                        });
                      },
                      icon: isRotated ? const Icon(Icons.double_arrow_sharp) : const Icon(Icons.arrow_back),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        if(!isMinimised)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 32, vertical: 8),
            color: Colors.grey[300],
            child: TextField(
              controller: searchController,
              onChanged: filterList,
              decoration: const InputDecoration(
                prefixIcon: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Icon(
                    Icons.search,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.indigoAccent, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                hintText: 'Filter locations',
              ),
            ),
          ),
        if(!isMinimised)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if(selectedItems.isNotEmpty)
                  Container(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0, top: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedItems.clear();
                            for (var filteredItem in filteredItems) {
                              filteredItem.isSelected = false;
                            }
                          });
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.close, size: 14, color: Colors.indigo),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Clear All",
                              style: TextStyle(fontSize: 12, color: Colors.indigo),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.grey[300],
                    child: AzListView(
                      data: filteredItems,
                      indexBarOptions: const IndexBarOptions(
                        indexHintAlignment: Alignment.centerRight,
                      ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return _buildListItem(item);
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    ),
  );

  Widget _buildListItem(CountryList item) => ListTile(
    leading: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: item.isSelected,
          onChanged: (bool? value) {
            toggleItemSelection(item);
          },
        ),
        const SizedBox(width: 8),
        item.image!="" ?
        Image.network(
          item.image,
          width: 20,
          height: 20,
          fit: BoxFit.cover,
        ) : Container(),
      ],
    ),
    title: Text("${item.country} - ${item.city}"),
  );

}
