import 'package:flutter/material.dart';


class CreateRoutineAppBar extends StatelessWidget {
  const CreateRoutineAppBar({super.key,});

  AppBar buildAppBar(BuildContext context) {
    
    
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.cancel_outlined,
          color: Colors.orange,
          size: 30,
        ),
      ),
      title: const Text(
        "CREATE ROUTINE",
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAppBar(context);
  }
}
