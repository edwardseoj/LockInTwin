import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/exercises.dart';
import 'package:lock_in_twin/main.dart';

import 'items/routines.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateRoutineState();
  }
}

class _CreateRoutineState extends State<CreateRoutine> {
  Color mainBg = const Color(0xFF302e2e);

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
  final routineObj = Routine();
  final _formKey = GlobalKey<FormState>();

  // helper functions and widgets
  Widget _routineTitleContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Routine Name',
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
            onSaved: (value) {
              routineObj.routineName = value.toString();
              print("Routine Name set to: ${routineObj.routineName}");
            },
          ),
        ],
        // )
      ),
    );
  }

  Widget _buildExerciseTile(String key) {
    final ex = _exercises[key]!;

    return ListTile(
      leading: ex.icon,
      tileColor: ex.isSelected ? Colors.orange : null,
      onTap: () => _toggleExercise(key),
      title: Text(ex.title, style: TextStyle(color: Colors.white)),
      subtitle: Text(ex.subtitle, style: TextStyle(color: Colors.white70)),
      trailing: Icon(
        ex.isSelected ? Icons.backspace_outlined : Icons.add_circle_outline,
        color: ex.isSelected ? Colors.white : Colors.orange,
      ),
    );
  }

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
        print("Selected Exercise: ${ex.key}");
      }
      print("${exObj.title} selected");
    });
  }

  Widget _continueButton() {
    return ElevatedButton(
      onPressed: () {
        // Save routine logic
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();   // <-- This triggers onSaved
        }
        Routine.copyExercises(_selectedExercises);
        routineObj.printExercises();
        routineObj.addRoutine();
        routineObj.printRoutines();

        // Move to main page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (Route<dynamic> route) => false,
        );

        print("Routine Saved");
      },

      // parent design
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _continueButtonDesign(),
      ),
    );
  }

  List<Widget> _continueButtonDesign() {
    // children widgets list
    var children = <Widget>[];

    children.add(
      SizedBox(
        height: 25,
        width: 25,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            textAlign: TextAlign.center,
            _exerciseCounter.toString(),
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
      ),
    );
    children.add(SizedBox(width: 10));
    children.add(
      Text('Continue', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
    children.add(Icon(Icons.navigate_next, color: Colors.white));

    return children;
  }

  // main build method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
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
                            print("Went to Home Page");
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
                    child: _routineTitleContent(),
                  ),

                  //exercise list and logic
                  Expanded(
                    child: ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        String key = _exercises.keys.elementAt(index);
                        return _buildExerciseTile(key);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Colors.white24);
                      },
                      itemCount: _exercises.length,
                    ),
                  ),

                  // continue button and saving logic
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _continueButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
