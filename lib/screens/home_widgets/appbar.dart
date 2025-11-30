import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Color appBarColor = const Color(0xFF000000);

    return AppBar(
      backgroundColor: appBarColor,
      title: Text("FME", style: TextStyle(color: Colors.white, fontSize: 30)),
      centerTitle: true,
    );
  }
}
