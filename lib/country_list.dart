import 'package:azlistview/azlistview.dart';

class CountryList extends ISuspensionBean {
  final String country;
  final String city;
  final String image;
  final String tag;
  bool isSelected;

  CountryList({
    required this.country,
    required this.city,
    required this.image,
    required this.tag,
    this.isSelected = false,
  });

  @override
  String getSuspensionTag() => tag;
}