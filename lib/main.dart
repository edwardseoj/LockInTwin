import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lock_in_twin/create_routine.dart';

import 'main_widgets/build_routine_display.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color appBarColor = const Color(0xFF000000);
    Color mainBg = const Color(0xFF302e2e);

    //for testing
    List<String> routines = [
      "Morning Routine",
      "Workout Routine",
      "Evening Routine",
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: mainBg,

            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: AppBar(
                backgroundColor: appBarColor,
                title: Center(
                  child: Text(
                    "FME",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (kDebugMode) {
                  print("Button pressed");
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateRoutine()),
                );
              },
              backgroundColor: Colors.orange,
              child: Icon(Icons.add),
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (routines.isEmpty) _emptyRoutinesWidget(),
                SlidableAutoCloseBehavior(
                  child: Center(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: routines.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BuildRoutineDisplay(
                          index: index,
                          routines: routines,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  // helper widget
  Widget _emptyRoutinesWidget() {
    return Center(
      child: Text(
        "No Routines",
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }
}
