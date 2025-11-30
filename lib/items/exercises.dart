import 'package:flutter/cupertino.dart';

class Exercises{
  String title;
  String subtitle;
  Widget icon;
  bool isSelected;
  List<Map<String, String>> sets = [];




  int set = 0;
  int rep = 0;




  Exercises({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
  });
}
