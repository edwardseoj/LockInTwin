import 'package:flutter/material.dart';
import 'package:lock_in_twin/screens/start_routine_widgets/build_excercise_row.dart';

import '../items/routines.dart';
import 'home_widgets/appbar.dart';

class StartRoutine extends StatefulWidget {
  final Routine routineObj;
  final int index;

  const StartRoutine({
    super.key,
    required this.routineObj,
    required this.index,
  });

  @override
  State<StatefulWidget> createState() => _StartRoutineState();
}

class _StartRoutineState extends State<StartRoutine> {
  Color mainBg = const Color(0xFF302e2e);

  Routine get routineObj => widget.routineObj;

  int get index => widget.index;

  @override
  Widget build(BuildContext context) {
    final routineName = routineObj.savedRoutines.keys.elementAt(index);
    final routineExercises = routineObj.savedRoutines.values.elementAt(index);
    final exerciseTitles = routineExercises.values.map((e) => e.title).toList();

    return Scaffold(
      backgroundColor: mainBg,

      // app bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(),
      ),

      // main contents
      body: Center(
        child: Column(
          children: [
            // routine name
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                routineName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),

            // rows for exercises
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return BuildExerciseRow(
                        title: exerciseTitles[index],
                        index: index,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 5);
                    },
                    itemCount: exerciseTitles.length,
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Finish routine",
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
