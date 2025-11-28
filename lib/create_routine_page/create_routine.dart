import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lock_in_twin/create_routine_page/continue_button.dart';
import 'package:lock_in_twin/create_routine_page/exercise_tile.dart';
import 'package:lock_in_twin/create_routine_page/routine_title_form.dart';
import 'package:lock_in_twin/items/exercises.dart';
import 'package:lock_in_twin/main.dart';

import '../items/routines.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<StatefulWidget> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  Color mainBg = const Color(0xFF302e2e);

  final routineObj = Routine();
  final _formKey = GlobalKey<FormState>();

  var _exerciseCounter = 0;

  final Map<String, Exercises> _exercises = {
    "Push Ups": Exercises(
      title: "Push Ups",
      subtitle: "Upper Body",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Squats": Exercises(
      title: "Squats",
      subtitle: "Lower Body",
      icon: const Icon(Icons.airline_seat_legroom_extra_sharp),
      isSelected: false,
    ),
    "Glute Bridges": Exercises(
      title: "Glute Bridges",
      subtitle: "Lower Body",
      icon: const Icon(Icons.airline_seat_legroom_extra_sharp),
      isSelected: false,
    ),
    "Pull Ups": Exercises(
      title: "Pull Ups",
      subtitle: "Upper Body",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank": Exercises(
      title: "Plank",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank1": Exercises(
      title: "Plank1",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank2": Exercises(
      title: "Plank2",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank3": Exercises(
      title: "Plank3",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank4": Exercises(
      title: "Plank4",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
    "Plank5": Exercises(
      title: "Plank5",
      subtitle: "Core",
      icon: const Icon(Icons.fitness_center),
      isSelected: false,
    ),
  };
  final Map<String, Exercises> _selectedExercises = {};

  // helper functions and widgets
  void _toggleExercise(String key) {
    setState(() {
      var exObj = _exercises[key]!;
      exObj.isSelected = !exObj.isSelected;

      if (exObj.isSelected) {
        _selectedExercises[key] = exObj;
        _exerciseCounter++;
      } else {
        _selectedExercises.remove(key);
        _exerciseCounter--;
      }

      // Debugging prints
      for (var ex in _selectedExercises.entries) {
        if (kDebugMode) {
          print("Selected Exercise: ${ex.key}");
        }
      }
      if (kDebugMode) {
        print("${exObj.title} selected");
      }
    });
  }

  // main build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBg,

      // App Bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.black,

          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("Went to Home Page");
                      }
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.orange,
                      size: 30,
                    ),
                  );
                },
              ),
            ],
          ),

          title: Text(
            "CREATE ROUTINE",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          centerTitle: true,
        ),
      ),

      // body
      body: SafeArea(
        child: Column(
          children: [
            // Routine title input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoutineTitleForm(formKey: _formKey, routine: routineObj),
            ),

            //exercise list and logic
            Expanded(
              child: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),

                itemBuilder: (BuildContext context, int index) {
                  String key = _exercises.keys.elementAt(index);
                  return ExerciseTile(
                    exercise: _exercises[key]!,
                    onTap: () => _toggleExercise(key),
                  );
                },

                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.white24),

                itemCount: _exercises.length,
              ),
            ),

            // continue button and saving logic
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButton(
                formKey: _formKey,
                routineObj: routineObj,
                selectedExercises: _selectedExercises,
                exerciseCounter: _exerciseCounter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
