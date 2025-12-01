import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lock_in_twin/items/routines.dart';
import 'package:lock_in_twin/screens/start_routine_screen.dart';

import '../edit_screen.dart';

class BuildRoutineDisplay extends StatelessWidget {
  final index;
  final Routine routineObj;
  final VoidCallback onDelete;

  const BuildRoutineDisplay({
    super.key,
    required this.index,
    required this.routineObj,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final routineName = routineObj.savedRoutines.keys.elementAt(index);
    final routineExercises = routineObj.savedRoutines.values.elementAt(index);
    final exerciseTitles = routineExercises.values.map((e) => e.title).toList();

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        // edit this for the width of routines
        constraints: BoxConstraints(maxWidth: 300),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: Slidable(
                groupTag: '0',
                startActionPane: ActionPane(
                  extentRatio: 0.30,
                  motion: const BehindMotion(),
                  children: [
                    CustomSlidableAction(
                      onPressed: (context) async {
                        if (kDebugMode) {
                          print("Edit ${routineObj.savedRoutines[index]}");
                        }
                        // Navigate to EditRoutine
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditRoutine(routineObj: routineObj)),
                        );
                      },
                      backgroundColor: Color(0xFF048BA8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final iconSize = math.min(
                            constraints.maxHeight * 0.35,
                            50.0,
                          );
                          return Center(
                            child: Icon(
                              Icons.edit_note_outlined,
                              size: iconSize,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.30,
                  motion: const BehindMotion(),
                  children: [
                    CustomSlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditRoutine(routineObj: routineObj),
                          ),
                        ).then((_) {
                          // Optional: refresh parent page after returning from edit
                          onDelete();
                        });
                      },
                      backgroundColor: const Color(0xFF048BA8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final iconSize = math.min(
                            constraints.maxHeight * 0.35,
                            50.0,
                          );
                          return Center(
                            child: Icon(
                              Icons.edit_note_outlined,
                              size: iconSize,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // design
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Column(
                    children: [
                      Text(
                        routineName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        exerciseTitles.join(", "),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        softWrap: true,
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: () {
                          if(kDebugMode){
                            print("Pressed start routine btn");
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartRoutine(routineObj: routineObj, index: index),
                            )
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.all(15),
                        ),
                        child: Text(
                          "Start routine",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
