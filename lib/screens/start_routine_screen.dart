import 'package:flutter/material.dart';

import '../items/routines.dart';
import 'home_widgets/appbar.dart';

class StartRoutine extends StatefulWidget{
  final Routine routineObj;
  const StartRoutine({super.key, required this.routineObj});

  @override
  State<StatefulWidget> createState() => _StartRoutineState();
}

class _StartRoutineState extends State<StartRoutine>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(),
      ),

      body: Text("Start routine page"),
    );
  }

}