import 'package:flutter/material.dart';

import '../../items/routines.dart';

class CreateRoutineAppBar2 extends StatelessWidget {
  final Routine routineObj;
  const CreateRoutineAppBar2({super.key, required this.routineObj});

  AppBar buildAppBar(BuildContext context) {


    return AppBar(

      // COLORING: AppBar Background Color
      backgroundColor: Colors.black,

      leading: IconButton(
        onPressed: () {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          String lastRoutineAdded = routineObj.savedRoutines.keys.last;
          if(currentRoute == "/CreateRoutine2"){
            routineObj.savedRoutines.remove(lastRoutineAdded);
          }
          Navigator.pop(context);
        },

        icon: const Icon(
          Icons.cancel_outlined,

          // COLORING: Exit Icon Color
          color: Colors.orange,
          size: 30,
        ),
      ),
      title: const Text(
        "CREATE ROUTINE",

        // COLORING: Title Color
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
